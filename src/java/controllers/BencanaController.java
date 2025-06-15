// Ganti 'controllers' dengan nama package Anda jika berbeda
package controllers;

// Pastikan semua import ini sesuai dengan struktur package Anda
import models.Bencana;
import models.DataPascaBencana;
import models.Logistik;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "BencanaController", urlPatterns = {"/bencana"})
public class BencanaController extends HttpServlet {

    /**
     * Menangani semua permintaan GET (menampilkan halaman).
     * Menggunakan parameter 'menu' untuk menentukan halaman mana yang akan ditampilkan.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String menu = request.getParameter("menu");

        // Switch-case untuk routing yang lebih rapi
        switch (menu == null ? "view" : menu) {
            case "view":
                // Menampilkan daftar semua bencana
                Bencana bencanaModel = new Bencana();
                ArrayList<Bencana> bencanaList = bencanaModel.get();
                request.setAttribute("bencanaList", bencanaList);
                request.getRequestDispatcher("/bencana/view.jsp").forward(request, response);
                break;
                
            case "add":
                request.getRequestDispatcher("/bencana/add.jsp").forward(request, response);
                break;
                
            case "edit":
                int idToEdit = Integer.parseInt(request.getParameter("id"));
                Bencana bencanaToEdit = new Bencana().find(idToEdit);
                request.setAttribute("bencana", bencanaToEdit);
                request.getRequestDispatcher("/bencana/edit.jsp").forward(request, response);
                break;
            
            case "detail":
                int idToDetail = Integer.parseInt(request.getParameter("id"));
                
                Bencana bencanaDetail = new Bencana().find(idToDetail);
                DataPascaBencana dataPascaBencana = new DataPascaBencana().find(idToDetail);
                ArrayList<Logistik> logistikDistribusi = new DataPascaBencana().getLogistikDistribusi(idToDetail);
                ArrayList<Logistik> semuaLogistik = new Logistik().get(); // Untuk dropdown
                
                request.setAttribute("bencana", bencanaDetail);
                request.setAttribute("dataPascaBencana", dataPascaBencana);
                request.setAttribute("logistikDistribusi", logistikDistribusi);
                request.setAttribute("semuaLogistik", semuaLogistik);
                
                request.getRequestDispatcher("/bencana/detail.jsp").forward(request, response);
                break;
            
              case "delete":
                System.out.println("--- [DEBUG] Aksi 'delete' dipanggil ---");
                String idStr = request.getParameter("id");
                System.out.println("--- [DEBUG] ID yang diterima dari URL: " + idStr);

                try {
                    int idToDelete = Integer.parseInt(idStr);
                    System.out.println("--- [DEBUG] ID berhasil di-parse menjadi: " + idToDelete);

                    Bencana bencanaToDelete = new Bencana();
                    bencanaToDelete.setId(idToDelete);
                    
                    System.out.println("--- [DEBUG] Memanggil method delete() pada model...");
                    boolean isDeleted = bencanaToDelete.delete(); // Method delete kita kembalikan boolean
                    
                    if(isDeleted) {
                        System.out.println("--- [DEBUG] Method delete() berhasil dijalankan.");
                    } else {
                        System.err.println("--- [ERROR] Method delete() gagal, cek pesan error di Model.");
                    }

                    System.out.println("--- [DEBUG] Melakukan redirect ke halaman view...");
                    response.sendRedirect("bencana?menu=view");
                    
                } catch (NumberFormatException e) {
                    System.err.println("--- [FATAL ERROR] Gagal parse ID! Pastikan ID adalah angka yang valid.");
                    System.err.println("--- Pesan Error: " + e.getMessage());
                    // Redirect ke halaman error atau halaman view dengan pesan error
                    response.sendRedirect("bencana?menu=view&error=invalid_id");
                } catch (Exception e) {
                    System.err.println("--- [FATAL ERROR] Terjadi exception lain saat proses delete.");
                    e.printStackTrace(); // Cetak full stack trace untuk debugging mendalam
                    response.sendRedirect("bencana?menu=view&error=delete_failed");
                }
                break;
                
            default:
                response.sendRedirect("bencana?menu=view");
                break;
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int id = (request.getParameter("id") != null) ? Integer.parseInt(request.getParameter("id")) : 0;

        // Aksi untuk menambah atau mengedit data bencana utama
        if ("add".equals(action) || "edit".equals(action)) {
            Bencana bencana = new Bencana();
            bencana.setTipe(request.getParameter("tipe"));
            bencana.setLokasi(request.getParameter("lokasi"));
            bencana.setLevel(request.getParameter("level"));
            try {
                String tanggalStr = request.getParameter("tanggal").replace("T", " ");
                Date tanggal = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(tanggalStr);
                bencana.setTanggal(tanggal);
            } catch (ParseException e) {
                bencana.setTanggal(new Date()); 
            }
            
            if ("add".equals(action)) {
                bencana.insert();
            } else {
                bencana.setId(id);
                bencana.update();
            }
            response.sendRedirect("bencana?menu=view");

        // Aksi untuk memperbarui data terdampak (jumlah korban & catatan)
        } else if ("update_detail".equals(action)) {
            DataPascaBencana dpb = new DataPascaBencana();
            dpb.setId(id);
            dpb.setJumlahKorban(Integer.parseInt(request.getParameter("jumlah_korban")));
            dpb.setCatatan(request.getParameter("catatan"));
            dpb.saveOrUpdate();
            
            response.sendRedirect("bencana?menu=detail&id=" + id);
        
        // Aksi untuk menambah distribusi logistik baru ke sebuah bencana
        } else if ("add_logistik_distribusi".equals(action)) {
            int logistikId = Integer.parseInt(request.getParameter("logistik_id"));
            int jumlahKeluar = Integer.parseInt(request.getParameter("jumlah_keluar"));
            
            DataPascaBencana dpb = new DataPascaBencana();
            dpb.tambahLogistikDistribusi(id, logistikId, jumlahKeluar);
            
            response.sendRedirect("bencana?menu=detail&id=" + id);
            
        } else {
            response.sendRedirect("bencana?menu=view");
        }
    }
}