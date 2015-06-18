/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.relatoriosChamar;

import com.afarma.banco.Conexao;
import com.afarma.controle.Venda;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;


/**
 *
 * @author Erick Medeiros
 */
public class emissaoNotaFiscal extends HttpServlet {


    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        PreparedStatement ps = null;
        ResultSet rs         = null;

     Boolean logado = (Boolean) request.getSession().getAttribute("Logado");
     RequestDispatcher rd = null;
     rd = request.getRequestDispatcher("/logar.jsp");



     if(logado != null){
        if(!logado){

            rd.forward(request, response);

        } else {


Connection conn = null;
      try {
String id_notaFiscal = request.getParameter("id_notaFiscal");
String sql = "SELECT   v.idVenda AS v_idVenda, "+
             " v.data AS v_data, v.formPagto AS v_formPagto, "+
             " v.cliente_id_cliente AS v_id_cliente, "+
             " v.totalDesconto AS v_totalDesconto, "+
             " v.nItens AS v_nItens, "+
             " v.totalItens AS v_totalItens, "+
             " v.nome AS v_ClienteNome, "+
             " v.cpfCliente AS v_cpfCliente, "+
             " v.emailFuncionario AS v_emailFuncionario, "+
             " vd.idProduto AS vd_idProduto, "+
             " vd.quantidade AS vd_quantidade, "+
             " vd.valor_venda AS vd_valor_venda, "+
             " vd.nome AS vd_ProdutoNome FROM "+
             " listar_intensvenda vd INNER JOIN listar_venda v ON vd.idvenda = v.idVenda "+
             " where v.idVenda = ? "+
             " ORDER BY v.idVenda, vd.idProduto ";

conn = Conexao.getConnection();
ps   = conn.prepareStatement(sql);
ps.setString(1,id_notaFiscal);
rs   = ps.executeQuery();


InputStream rel = getClass().getResourceAsStream("../relatorios/NotaFiscal.jasper");
JasperReport relatorioJasper = (JasperReport)JRLoader.loadObject(rel);

JRResultSetDataSource jrRS = new JRResultSetDataSource(rs);

          HashMap parametros = new HashMap();

         byte bytes[] = JasperRunManager.runReportToPdf(relatorioJasper,parametros,jrRS);

             response.setContentType("application/pdf");
             response.setContentLength(bytes.length);
             ServletOutputStream ouputStream = response.getOutputStream();
             ouputStream.write(bytes, 0, bytes.length);
             ouputStream.flush();
             ouputStream.close();

             Conexao.CloseConnection(conn,ps,rs);


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
