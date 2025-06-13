// Simpan di: models/Bencana.java
package models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

// 1. Mewarisi (extends) abstract class Model<Bencana>
public class Bencana extends Model<Bencana> {
    
    // Atribut tetap sama
    private int id;
    private String tipe;
    private String lokasi;
    private String level;
    private Date tanggal;

    // 2. Buat constructor untuk mendefinisikan nama tabel dan primary key
    public Bencana() {
        super(); // Panggil constructor parent
        this.table = "bencana";      // Wajib: set nama tabel
        this.primaryKey = "id";      // Wajib: set nama primary key
    }

    // Getters and Setters (tetap sama, tidak perlu diubah)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTipe() { return tipe; }
    public void setTipe(String tipe) { this.tipe = tipe; }
    public String getLokasi() { return lokasi; }
    public void setLokasi(String lokasi) { this.lokasi = lokasi; }
    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
    public Date getTanggal() { return tanggal; }
    public void setTanggal(Date tanggal) { this.tanggal = tanggal; }

    // 3. Implementasikan method abstract toModel dari parent
    @Override
    protected Bencana toModel(ResultSet rs) throws SQLException {
        Bencana b = new Bencana();
        b.setId(rs.getInt("id"));
        b.setTipe(rs.getString("tipe"));
        b.setLokasi(rs.getString("lokasi"));
        b.setLevel(rs.getString("level"));
        b.setTanggal(rs.getTimestamp("tanggal"));
        return b;
    }
}