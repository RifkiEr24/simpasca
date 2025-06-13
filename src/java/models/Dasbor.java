package models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Dasbor {

    // Atribut untuk menampung semua data yang telah diambil
    private ArrayList<Bencana> semuaBencana;
    private ArrayList<DataPascaBencana> semuaDataPasca;
    private ArrayList<AlurKas> semuaKas;
    private ArrayList<Logistik> semuaLogistik;
    
    // Atribut untuk hasil kalkulasi
    private int totalKorban = 0;
    private double totalKasMasuk = 0;
    private double totalKasKeluar = 0;

    /**
     * Constructor Dasbor.
     * Saat objek Dasbor dibuat, ia akan langsung mengambil semua data
     * yang diperlukan dari database dan melakukan kalkulasi.
     */
    public Dasbor() {
        // Ambil semua data dari masing-masing model
        this.semuaBencana = new Bencana().get();
        this.semuaDataPasca = new DataPascaBencana().get();
        this.semuaKas = new AlurKas().get();
        this.semuaLogistik = new Logistik().get();
        
        // Lakukan kalkulasi statistik
        this.calculateStats();
    }
    
    /**
     * Method internal untuk menghitung semua statistik.
     */
    private void calculateStats() {
        // Menghitung total korban
        if (semuaDataPasca != null) {
            for (DataPascaBencana dpb : semuaDataPasca) {
                totalKorban += dpb.getJumlahKorban();
            }
        }
        
        // Menghitung total kas masuk dan keluar
        if (semuaKas != null) {
            for (AlurKas kas : semuaKas) {
                if ("Masuk".equals(kas.getTipe())) {
                    totalKasMasuk += kas.getNominal();
                } else {
                    totalKasKeluar += kas.getNominal();
                }
            }
        }
    }

    // --- GETTER UNTUK KARTU STATISTIK ---
    
    public int getTotalBencana() {
        return (semuaBencana != null) ? semuaBencana.size() : 0;
    }
    
    public int getTotalKorban() {
        return this.totalKorban;
    }
    
    public double getTotalKasMasuk() {
        return this.totalKasMasuk;
    }
    
    public double getTotalKasKeluar() {
        return this.totalKasKeluar;
    }

    // --- GETTER UNTUK TABEL RINGKASAN ---
    
    public ArrayList<Bencana> getBencanaTerbaru(int limit) {
        ArrayList<Bencana> terbaru = new ArrayList<>();
        if (semuaBencana != null) {
            for (int i = 0; i < Math.min(limit, semuaBencana.size()); i++) {
                terbaru.add(semuaBencana.get(i));
            }
        }
        return terbaru;
    }
    
    public ArrayList<AlurKas> getKasTerbaru(int limit) {
        ArrayList<AlurKas> terbaru = new ArrayList<>();
        if (semuaKas != null) {
            for (int i = 0; i < Math.min(limit, semuaKas.size()); i++) {
                terbaru.add(semuaKas.get(i));
            }
        }
        return terbaru;
    }
    
    // --- Method untuk mengambil logistik yang stoknya kritis ---
    public ArrayList<Logistik> getLogistikKritis(int batasStok) {
        ArrayList<Logistik> kritis = new ArrayList<>();
        if (semuaLogistik != null) {
            for (Logistik log : semuaLogistik) {
                if (log.getQty() <= batasStok) {
                    kritis.add(log);
                }
            }
        }
        return kritis;
    }
}