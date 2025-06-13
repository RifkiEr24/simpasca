// Simpan di: models/Logistik.java
package models;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class Logistik extends Model<Logistik> {

    // --- Atribut ---
    private int id;
    private String nama;
    private String kategori;
    private String satuan;
    private int qty;
    private double rasioPerKorban; // Atribut baru untuk sistem rasio
    private String unitRasio;      // Atribut baru untuk sistem rasio

    /**
     * Constructor untuk mendefinisikan nama tabel yang digunakan oleh parent Model.
     */
    public Logistik() {
        super();
        this.table = "logistik";
        this.primaryKey = "id";
    }

    // --- Getters and Setters (Lengkap) ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }
    public String getKategori() { return kategori; }
    public void setKategori(String kategori) { this.kategori = kategori; }
    public String getSatuan() { return satuan; }
    public void setSatuan(String satuan) { this.satuan = satuan; }
    public int getQty() { return qty; }
    public void setQty(int qty) { this.qty = qty; }
    public double getRasioPerKorban() { return rasioPerKorban; }
    public void setRasioPerKorban(double rasioPerKorban) { this.rasioPerKorban = rasioPerKorban; }
    public String getUnitRasio() { return unitRasio; }
    public void setUnitRasio(String unitRasio) { this.unitRasio = unitRasio; }

    /**
     * Mengubah satu baris dari ResultSet menjadi sebuah objek Logistik.
     */
    @Override
    protected Logistik toModel(ResultSet rs) throws SQLException {
        Logistik log = new Logistik();
        log.setId(rs.getInt("id"));
        log.setNama(rs.getString("nama"));
        log.setKategori(rs.getString("kategori"));
        log.setSatuan(rs.getString("satuan"));
        log.setQty(rs.getInt("qty"));
        log.setRasioPerKorban(rs.getDouble("rasio_per_korban"));
        log.setUnitRasio(rs.getString("unit_rasio"));
        return log;
    }
    
    /**
     * Mencatat penerimaan stok baru (misal: donasi) dan memperbarui jumlah total.
     */
    public boolean catatPenerimaanStok(int jumlah, String keterangan) {
        this.connect();
        try {
            // 1. Catat di riwayat sebagai 'Masuk'
            String riwayatQuery = "INSERT INTO logistik_riwayat (logistik_id, tipe, jumlah, keterangan, tanggal) VALUES (?, 'Masuk', ?, ?, ?)";
            PreparedStatement riwayatPstmt = this.con.prepareStatement(riwayatQuery);
            riwayatPstmt.setInt(1, this.getId());
            riwayatPstmt.setInt(2, jumlah);
            riwayatPstmt.setString(3, keterangan);
            riwayatPstmt.setTimestamp(4, new java.sql.Timestamp(new Date().getTime()));
            riwayatPstmt.executeUpdate();
            riwayatPstmt.close();

            // 2. Update kuantitas total di tabel logistik
            String updateStokQuery = "UPDATE logistik SET qty = qty + ? WHERE id = ?";
            PreparedStatement updateStokPstmt = this.con.prepareStatement(updateStokQuery);
            updateStokPstmt.setInt(1, jumlah);
            updateStokPstmt.setInt(2, this.getId());
            updateStokPstmt.executeUpdate();
            updateStokPstmt.close();

            return true;
        } catch (SQLException e) {
            System.out.println("Error catatPenerimaanStok: " + e.getMessage());
            return false;
        } finally {
            this.disconnect();
        }
    }

    /**
     * Mengambil semua riwayat pergerakan stok untuk item logistik ini.
     */
    public ArrayList<LogistikRiwayat> getRiwayat() {
        ArrayList<LogistikRiwayat> riwayatList = new ArrayList<>();
        String query = "SELECT * FROM logistik_riwayat WHERE logistik_id = ? ORDER BY tanggal DESC";
        this.connect();
        try {
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, this.getId());
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                LogistikRiwayat riwayat = new LogistikRiwayat();
                riwayat.setId(rs.getInt("id"));
                riwayat.setLogistikId(rs.getInt("logistik_id"));
                riwayat.setTipe(rs.getString("tipe"));
                riwayat.setJumlah(rs.getInt("jumlah"));
                riwayat.setKeterangan(rs.getString("keterangan"));
                riwayat.setTanggal(rs.getTimestamp("tanggal"));
                riwayat.setKasId(rs.getInt("kas_id"));
                riwayat.setBencanaId(rs.getInt("bencana_id"));
                riwayatList.add(riwayat);
            }
        } catch (SQLException e) {
            System.out.println("Error getRiwayat: " + e.getMessage());
        } finally {
            this.disconnect();
        }
        return riwayatList;
    }
}