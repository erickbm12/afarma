/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.relatoriosChamar;

import com.afarma.banco.Conexao;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

/**
 *
 * @author Erick Medeiros
 */
public class RelListaProdutos extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

     Boolean logado = (Boolean) request.getSession().getAttribute("Logado");
     RequestDispatcher rd = null;
     rd = request.getRequestDispatcher("/logar.jsp");

     if(logado != null){
        if(!logado){

            rd.forward(request, response);

        } else {


Connection conn = null;
      try {


conn = Conexao.getConnection();
InputStream rel = getClass().getResourceAsStream("../relatorios/rel_ListaProdutos.jasper");
                                               // endereco do pacote
JasperReport relatorioJasper = (JasperReport)JRLoader.loadObject(rel);

          HashMap parametros = new HashMap();

         byte bytes[] = JasperRunManager.runReportToPdf(relatorioJasper,parametros,conn);

             response.setContentType("application/pdf");
             response.setContentLength(bytes.length);
             ServletOutputStream ouputStream = response.getOutputStream();
             ouputStream.write(bytes, 0, bytes.length);
             ouputStream.flush();
             ouputStream.close();

             conn.close();

         } catch (JRException e) {
            e.printStackTrace();
         }  catch(Exception ez){
             ez.printStackTrace();
         }
        }
     }else{
       rd.forward(request, response);
     }

    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
