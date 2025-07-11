// Simpan di: controllers/AlurKasController.java (Final)
package controllers;

import models.AlurKas;
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

@WebServlet(name = "AlurKasController", urlPatterns = {"/kas"})
public class AlurKasController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String menu = request.getParameter("menu");
        AlurKas alurKasModel = new AlurKas();

        switch (menu == null ? "view" : menu) {
            case "view":
                ArrayList<AlurKas> kasList = alurKasModel.get();
                request.setAttribute("kasList", kasList);
                request.getRequestDispatcher("/kas/view.jsp").forward(request, response);
                break;
                
            case "add":
                ArrayList<Logistik> semuaLogistik = new Logistik().get();
                request.setAttribute("semuaLogistik", semuaLogistik);
                request.getRequestDispatcher("/kas/add.jsp").forward(request, response);
                break;
                
            case "edit":
                // --- BAGIAN INI DILENGKAPI ---
                int id = Integer.parseInt(request.getParameter("id"));
                AlurKas kas = alurKasModel.find(id);
                request.setAttribute("kas", kas);
                // Kita tidak akan mengizinkan pengubahan logistik tertaut via form ini
                // untuk menghindari kompleksitas, jadi tidak perlu mengirim daftar logistik.
                request.getRequestDispatcher("/kas/edit.jsp").forward(request, response);
                break;
            
            case "delete":
                int idToDelete = Integer.parseInt(request.getParameter("id"));
                AlurKas toDelete = new AlurKas();
                toDelete.setId(idToDelete);
                toDelete.delete();
                response.sendRedirect("kas?menu=view");
                break;
                
            default:
                response.sendRedirect("kas?menu=view");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            AlurKas kas = new AlurKas();
            kas.setTipe(request.getParameter("tipe"));
            kas.setNominal(Double.parseDouble(request.getParameter("nominal")));
            kas.setKeterangan(request.getParameter("keterangan"));
            try {
                Date tanggal = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("tanggal"));
                kas.setTanggal(tanggal);
            } catch (ParseException e) {
                kas.setTanggal(new Date());
            }
            kas.saveWithLogistik(
                request.getParameter("logistik_id"), 
                request.getParameter("jumlah_logistik")
            );

        } else if ("edit".equals(action)) {
            AlurKas kas = new AlurKas();
            kas.setId(Integer.parseInt(request.getParameter("id")));
            kas.setTipe(request.getParameter("tipe"));
            kas.setNominal(Double.parseDouble(request.getParameter("nominal")));
            kas.setKeterangan(request.getParameter("keterangan"));
            try {
                Date tanggal = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("tanggal"));
                kas.setTanggal(tanggal);
            } catch (ParseException e) {
               
            }
            kas.update(); // 
        }

        response.sendRedirect("kas?menu=view");
    }
}