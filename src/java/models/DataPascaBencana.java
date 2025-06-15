package models;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class DataPascaBencana extends Model<DataPascaBencana> {

    private int id; 
    private int jumlahKorban;
    private String catatan;

    public DataPascaBencana() {
        super();
        this.table = "data_pasca_bencana";
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getJumlahKorban() { return jumlahKorban; }
    public void setJumlahKorban(int jumlahKorban) { this.jumlahKorban = jumlahKorban; }
    public String getCatatan() { return catatan; }
    public void setCatatan(String catatan) { this.catatan = catatan; }

    @Override
    protected DataPascaBencana toModel(ResultSet rs) throws SQLException {
        DataPascaBencana dpb = new DataPascaBencana();
        dpb.setId(rs.getInt("id"));
        dpb.setJumlahKorban(rs.getInt("jumlah_korban"));
        dpb.setCatatan(rs.getString("catatan"));
        return dpb;
    }

    public ArrayList<Logistik> getLogistikDistribusi(int bencanaId) {
        ArrayList<Logistik> list = new ArrayList<>();
        String query = "SELECT l.nama, l.satuan, lr.jumlah "
                     + "FROM logistik_riwayat lr "
                     + "JOIN logistik l ON lr.logistik_id = l.id "
                     + "WHERE lr.bencana_id = ? AND lr.tipe = 'Keluar'";
        
        this.connect();
        try {
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, bencanaId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Logistik log = new Logistik();
                log.setNama(rs.getString("nama"));
                log.setSatuan(rs.getString("satuan"));
                log.setQty(rs.getInt("jumlah")); // 'qty' di sini merepresentasikan jumlah yang keluar
                list.add(log);
            }
        } catch (SQLException e) {
            System.out.println("Error getLogistikDistribusi: " + e.getMessage());
        } finally {
            this.disconnect();
        }
        return list;
    }

    public void saveOrUpdate() {
        this.connect();
        try {
            String checkQuery = "SELECT COUNT(*) as rowcount FROM " + this.table + " WHERE id = " + this.id;
            ResultSet rs = this.stmt.executeQuery(checkQuery);
            rs.next();
            int count = rs.getInt("rowcount");
            rs.close();

            String query;
            if (count > 0) {
                query = String.format("UPDATE %s SET jumlah_korban = %d, catatan = '%s' WHERE id = %d",
                                      this.table, this.jumlahKorban, this.catatan, this.id);
            } else {
                query = String.format("INSERT INTO %s (id, jumlah_korban, catatan) VALUES (%d, %d, '%s')",
                                      this.table, this.id, this.jumlahKorban, this.catatan);
            }
            this.stmt.executeUpdate(query);
            
        } catch (SQLException e) {
            System.out.println("Error saveOrUpdate: " + e.getMessage());
        } finally {
            this.disconnect();
        }
    }
    

    public boolean tambahLogistikDistribusi(int bencanaId, int logistikId, int jumlah) {
        this.connect();
        try {
            // 1. Catat di riwayat sebagai 'Keluar' dan tautkan ke bencana_id
            String riwayatQuery = "INSERT INTO logistik_riwayat (logistik_id, tipe, jumlah, keterangan, tanggal, bencana_id) VALUES (?, 'Keluar', ?, ?, ?, ?)";
            PreparedStatement riwayatPstmt = this.con.prepareStatement(riwayatQuery);
            riwayatPstmt.setInt(1, logistikId);
            riwayatPstmt.setInt(2, jumlah);
            riwayatPstmt.setString(3, "Distribusi untuk bencana ID: " + bencanaId);
            riwayatPstmt.setTimestamp(4, new java.sql.Timestamp(new Date().getTime()));
            riwayatPstmt.setInt(5, bencanaId);
            riwayatPstmt.executeUpdate();
            riwayatPstmt.close();

            // 2. Kurangi stok di tabel logistik utama
            String updateStokQuery = "UPDATE logistik SET qty = qty - ? WHERE id = ?";
            PreparedStatement updateStokPstmt = this.con.prepareStatement(updateStokQuery);
            updateStokPstmt.setInt(1, jumlah);
            updateStokPstmt.setInt(2, logistikId);
            updateStokPstmt.executeUpdate();
            updateStokPstmt.close();

            return true;
        } catch (SQLException e) {
            System.out.println("Error tambahLogistikDistribusi: " + e.getMessage());
            return false;
        } finally {
            this.disconnect();
        }
    }
}