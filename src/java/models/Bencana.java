package models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class Bencana extends Model<Bencana> {
    
    private int id;
    private String tipe;
    private String lokasi;
    private String level;
    private Date tanggal;

    public Bencana() {
        super(); 
        this.table = "bencana";    
        this.primaryKey = "id";     
    }

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