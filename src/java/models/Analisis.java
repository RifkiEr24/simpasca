/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Rifki Erlangga
 */
import java.util.List;

public interface Analisis {
    List<DataPascaBencana> getDataPascaBencana();
    List<Logistik> getDataLogistik();
    List<AlurKas> getDataAlurKas();
    int getJumlahBencanaHariIni();
    int getJumlahKorbanHariIni();
}