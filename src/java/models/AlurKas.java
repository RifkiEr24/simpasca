// Simpan di: models/AlurKas.java
package models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.Statement;

// 1. Mewarisi abstract class Model<AlurKas>
public class AlurKas extends Model<AlurKas> {

    private int id;
    private double nominal;
    private String tipe; // "Masuk" atau "Keluar"
    private String keterangan;
    private Date tanggal;

    // 2. Constructor untuk mendefinisikan nama tabel
    public AlurKas() {
        super();
        this.table = "alur_kas";
    }

    // Getters and Setters
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
    
    // 3. Implementasi method abstract toModel
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
            
            pstmt.executeUpdate();
            pstmt.close();
            return true;
            
        } catch (SQLException e) {
            System.out.println("Error update AlurKas: " + e.getMessage());
            return false;
        } finally {
            this.disconnect();
        }
    }
    public void saveWithLogistik(String logistikIdStr, String jumlahLogistikStr) {
    this.connect();
    try {
        // 1. Simpan data Alur Kas dan dapatkan ID nya
        String kasQuery = "INSERT INTO alur_kas (nominal, tipe, keterangan, tanggal) VALUES (?, ?, ?, ?)";
        PreparedStatement kasPstmt = this.con.prepareStatement(kasQuery, Statement.RETURN_GENERATED_KEYS);
        kasPstmt.setDouble(1, this.getNominal());
        kasPstmt.setString(2, this.getTipe());
        kasPstmt.setString(3, this.getKeterangan());
        kasPstmt.setDate(4, new java.sql.Date(this.getTanggal().getTime()));
        kasPstmt.executeUpdate();

        // Ambil ID dari kas yang baru saja di-insert
        ResultSet generatedKeys = kasPstmt.getGeneratedKeys();
        int newKasId = -1;
        if (generatedKeys.next()) {
            newKasId = generatedKeys.getInt(1);
        }
        kasPstmt.close();
        
        // 2. Jika ini adalah transaksi pembelian logistik, proses logistiknya
        if ("Keluar".equals(this.getTipe()) && logistikIdStr != null && !logistikIdStr.isEmpty()) {
            int logistikId = Integer.parseInt(logistikIdStr);
            int jumlah = Integer.parseInt(jumlahLogistikStr);
            
            if (logistikId > 0 && jumlah > 0 && newKasId != -1) {
                String riwayatQuery = "INSERT INTO logistik_riwayat (logistik_id, tipe, jumlah, keterangan, tanggal, kas_id) VALUES (?, 'Masuk', ?, ?, ?, ?)";
                PreparedStatement riwayatPstmt = this.con.prepareStatement(riwayatQuery);
                riwayatPstmt.setInt(1, logistikId);
                riwayatPstmt.setInt(2, jumlah);
                riwayatPstmt.setString(3, "Pembelian: " + this.getKeterangan());
                riwayatPstmt.setTimestamp(4, new java.sql.Timestamp(new Date().getTime()));
                riwayatPstmt.setInt(5, newKasId);
                riwayatPstmt.executeUpdate();
                riwayatPstmt.close();

                String updateStokQuery = "UPDATE logistik SET qty = qty + ? WHERE id = ?";
                PreparedStatement updateStokPstmt = this.con.prepareStatement(updateStokQuery);
                updateStokPstmt.setInt(1, jumlah);
                updateStokPstmt.setInt(2, logistikId);
                updateStokPstmt.executeUpdate();
                updateStokPstmt.close();
            }
        }

    } catch (SQLException e) {
        System.out.println("Error saveWithLogistik: " + e.getMessage());
    } finally {
        this.disconnect();
    }
}
}