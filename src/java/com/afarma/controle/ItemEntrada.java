/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.controle;
import com.afarma.banco.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

/**
 *
 * @author Erick Medeiros
 */
public class ItemEntrada {
    private int idEntrada;
    private int quantidade;
    private double valorCompra;
    private Produto produto;

    private Connection conn;

    public ItemEntrada(){
       this.idEntrada = 0;
       this.quantidade=0;
       this.valorCompra = 0;
       this.produto = new Produto();
    }


    public int getQtd() {
        return quantidade;
    }
    public double getValor() {
        return valorCompra;
    }
    public Produto getProduto() {
        return produto;
    }
    public void setQtd(int pQtd) {
        quantidade = pQtd;
    }
    public void setValor(double pValor) {
        valorCompra = pValor;
    }
    public void setProduto(Produto pProd) {
        produto = pProd;
    }

    /**
     * @return the idEntrada
     */
    public int getIdEntrada() {
        return idEntrada;
    }

    /**
     * @param idEntrada the idEntrada to set
     */
    public void setIdEntrada(int idEntrada) {
        this.idEntrada = idEntrada;
    }

    public void instanciarItenEntrada(int idEntrada, Produto pProduto) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select  produto_idProduto, quantidade, valor_compra "+
                     "from item_entrada where entrada_idEntrada=? and produto_idProduto=?";

        setProduto(pProduto);

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, idEntrada);
            ps.setInt(2, pProduto.getIdProduto());
            rs   = ps.executeQuery();

            if(rs.next()){

    setIdEntrada(idEntrada);
    setQtd(rs.getInt(2));
    setValor(rs.getDouble(3));


            }

            }catch(SQLException sqle){
                throw new Exception("Error Instanciar Item Entrada "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

}
