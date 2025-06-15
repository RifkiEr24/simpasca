package models;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class AlurKas extends Model<AlurKas> {
    private int id;
    private double nominal;
    private String tipe;
    private String keterangan;
    private Date tanggal;

    public AlurKas() {
        super();
        this.table = "alur_kas";
    }

    @Override
    protected AlurKas toModel(ResultSet rs) throws SQLException {
        AlurKas kas = new AlurKas();
        kas.setId(rs.getInt("id"));
        kas.setNominal(rs.getDouble("nominal"));
        kas.setTipe(rs.getString("tipe"));
        kas.setKeterangan(rs.getString("keterangan"));
        kas.setTanggal(rs.getDate("tanggal"));
        return kas;
    }
    
    @Override
    protected Object getPrimaryKeyValue() {
        return this.getId();
    }
    
    public void saveWithLogistik(String logistikIdStr, String jumlahLogistikStr) {
        this.connect();
        try {
            // 1. Simpan Alur Kas
            String kasQuery = "INSERT INTO alur_kas (nominal, tipe, keterangan, tanggal) VALUES (?, ?, ?, ?)";
            PreparedStatement kasPstmt = this.con.prepareStatement(kasQuery, Statement.RETURN_GENERATED_KEYS);
            kasPstmt.setDouble(1, this.getNominal());
            kasPstmt.setString(2, this.getTipe());
            kasPstmt.setString(3, this.getKeterangan());
            kasPstmt.setDate(4, new java.sql.Date(this.getTanggal().getTime()));
            kasPstmt.executeUpdate();

            ResultSet generatedKeys = kasPstmt.getGeneratedKeys();
            int newKasId = -1;
            if (generatedKeys.next()) {
                newKasId = generatedKeys.getInt(1);
            }
            kasPstmt.close();
            
            // 2. Jika pembelian logistik, proses logistiknya
            if ("Keluar".equals(this.getTipe()) && logistikIdStr != null && !logistikIdStr.isEmpty()) {
                int logistikId = Integer.parseInt(logistikIdStr);
                int jumlah = Integer.parseInt(jumlahLogistikStr);
                
                if (logistikId > 0 && jumlah > 0 && newKasId != -1) {
                    // 2a. Catat di riwayat
                    String riwayatQuery = "INSERT INTO logistik_riwayat (logistik_id, tipe, jumlah, keterangan, tanggal, kas_id) VALUES (?, 'Masuk', ?, ?, ?, ?)";
                    PreparedStatement riwayatPstmt = this.con.prepareStatement(riwayatQuery);
                    riwayatPstmt.setInt(1, logistikId);
                    riwayatPstmt.setInt(2, jumlah);
                    riwayatPstmt.setString(3, "Pembelian: " + this.getKeterangan());
                    riwayatPstmt.setTimestamp(4, new java.sql.Timestamp(new Date().getTime()));
                    riwayatPstmt.setInt(5, newKasId);
                    riwayatPstmt.executeUpdate();
                    riwayatPstmt.close();

                    // 2b. Update stok
                    String updateStokQuery = "UPDATE logistik SET qty = qty + ? WHERE id = ?";
                    PreparedStatement updateStokPstmt = this.con.prepareStatement(updateStokQuery);
                    updateStokPstmt.setInt(1, jumlah);
                    updateStokPstmt.setInt(2, logistikId);
                    updateStokPstmt.executeUpdate();
                    updateStokPstmt.close();
                }
            }
        } catch (SQLException e) {
            // handle error
        } finally {
            this.disconnect();
        }
    }
    
    public boolean update() {
        this.connect();
        try {
            String query = "UPDATE alur_kas SET tipe = ?, nominal = ?, keterangan = ?, tanggal = ? WHERE id = ?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, this.getTipe());
            pstmt.setDouble(2, this.getNominal());
            pstmt.setString(3, this.getKeterangan());
            pstmt.setDate(4, new java.sql.Date(this.getTanggal().getTime()));
            pstmt.setInt(5, this.getId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        } finally {
            this.disconnect();
        }
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public double getNominal() { return nominal; }
    public void setNominal(double nominal) { this.nominal = nominal; }
    public String getTipe() { return tipe; }
    public void setTipe(String tipe) { this.tipe = tipe; }
    public String getKeterangan() { return keterangan; }
    public void setKeterangan(String keterangan) { this.keterangan = keterangan; }
    public Date getTanggal() { return tanggal; }
    public void setTanggal(Date tanggal) { this.tanggal = tanggal; }
}