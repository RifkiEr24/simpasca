// Simpan di: models/LogistikRiwayat.java
package models;

import java.util.Date;

public class LogistikRiwayat {
    private int id;
    private int logistikId;
    private String tipe;
    private int jumlah;
    private String keterangan;
    private Date tanggal;
    private int kasId;
    private int bencanaId;


    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getLogistikId() { return logistikId; }
    public void setLogistikId(int logistikId) { this.logistikId = logistikId; }
    public String getTipe() { return tipe; }
    public void setTipe(String tipe) { this.tipe = tipe; }
    public int getJumlah() { return jumlah; }
    public void setJumlah(int jumlah) { this.jumlah = jumlah; }
    public String getKeterangan() { return keterangan; }
    public void setKeterangan(String keterangan) { this.keterangan = keterangan; }
    public Date getTanggal() { return tanggal; }
    public void setTanggal(Date tanggal) { this.tanggal = tanggal; }
    public int getKasId() { return kasId; }
    public void setKasId(int kasId) { this.kasId = kasId; }
    public int getBencanaId() { return bencanaId; }
    public void setBencanaId(int bencanaId) { this.bencanaId = bencanaId; }
}