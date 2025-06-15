package controllers;

import models.Logistik;
import models.LogistikRiwayat;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LogistikController", urlPatterns = {"/logistik"})
public class LogistikController extends HttpServlet {

    /**
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String menu = request.getParameter("menu");
        Logistik logistikModel = new Logistik();

        switch (menu == null ? "view" : menu) {
            case "view":
                ArrayList<Logistik> logistikList = logistikModel.get();
                request.setAttribute("logistikList", logistikList);
                request.getRequestDispatcher("/logistik/view.jsp").forward(request, response);
                break;
                
            case "add":
                request.getRequestDispatcher("/logistik/add.jsp").forward(request, response);
                break;
                
            case "edit":
                int idToEdit = Integer.parseInt(request.getParameter("id"));
                Logistik logistikToEdit = logistikModel.find(idToEdit);
                request.setAttribute("logistik", logistikToEdit);
                request.getRequestDispatcher("/logistik/edit.jsp").forward(request, response);
                break;

            case "terima":
                ArrayList<Logistik> semuaLogistik = logistikModel.get();
                request.setAttribute("semuaLogistik", semuaLogistik);
                request.getRequestDispatcher("/logistik/terima.jsp").forward(request, response);
                break;
            
            case "riwayat":
                int idToView = Integer.parseInt(request.getParameter("id"));
                Logistik logistikDetail = logistikModel.find(idToView);
                ArrayList<LogistikRiwayat> riwayatList = logistikDetail.getRiwayat();
                
                request.setAttribute("logistik", logistikDetail);
                request.setAttribute("riwayatList", riwayatList);
                request.getRequestDispatcher("/logistik/riwayat.jsp").forward(request, response);
                break;
            
            case "delete":
                int idToDelete = Integer.parseInt(request.getParameter("id"));
                Logistik toDelete = new Logistik();
                toDelete.setId(idToDelete);
                toDelete.delete();
                response.sendRedirect("logistik?menu=view");
                break;
                
            default:
                response.sendRedirect("logistik?menu=view");
                break;
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action) || "edit".equals(action)) {
            Logistik logistik = new Logistik();
            logistik.setNama(request.getParameter("nama"));
            logistik.setKategori(request.getParameter("kategori"));
            logistik.setSatuan(request.getParameter("satuan"));
            logistik.setQty(Integer.parseInt(request.getParameter("qty")));
            logistik.setRasioPerKorban(Double.parseDouble(request.getParameter("rasio_per_korban")));
            logistik.setUnitRasio(request.getParameter("unit_rasio"));

            if ("add".equals(action)) {
                logistik.insert();
            } else {
                logistik.setId(Integer.parseInt(request.getParameter("id")));
                logistik.update();
            }
            response.sendRedirect("logistik?menu=view");
            return;
        }
        
        if ("terima_stok".equals(action)) {
            int logistikId = Integer.parseInt(request.getParameter("logistik_id"));
            int jumlah = Integer.parseInt(request.getParameter("jumlah"));
            String keterangan = request.getParameter("keterangan");
            
            Logistik logistik = new Logistik();
            logistik.setId(logistikId);
            logistik.catatPenerimaanStok(jumlah, keterangan);
            
            response.sendRedirect("logistik?menu=view");
            return;
        }
        
        response.sendRedirect("logistik?menu=view");
    }
}