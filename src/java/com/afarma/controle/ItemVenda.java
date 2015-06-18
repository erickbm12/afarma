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
public class ItemVenda {
    private int idVenda;
    private int quantidade;
    private double valor;
    private Produto produto;

     private Connection conn;

    public ItemVenda(){

        this.idVenda    = 0;
        this.quantidade = 0;
        this.valor      = 0.0;
        this.produto = new Produto();


    }

    /**
     * @return the quantidade
     */
    public int getQtd() {
        return quantidade;
    }

    /**
     * @param quantidade the quantidade to set
     */
    public void setQtd(int pQtd) {
        this.quantidade = pQtd;
    }

    /**
     * @return the produto
     */
    public Produto getProduto() {
        return produto;
    }

    /**
     * @param produto the produto to set
     */
    public void setProduto(Produto pProd) {
        this.produto = pProd;
    }

    /**
     * @return the idVenda
     */
    public int getIdVenda() {
        return idVenda;
    }

    /**
     * @param idVenda the idVenda to set
     */
    public void setIdVenda(int idVenda) {
        this.idVenda = idVenda;
    }

    /**
     * @return the valor
     */
    public double getValor() {
        return valor;
    }

    /**
     * @param valor the valor to set
     */
    public void setValor(double valor) {
        this.valor = valor;
    }

    public void instanciarItenVenda(int idVenda, Produto pProduto) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select  idProduto, quantidade, valor_venda "+
                     "from item_venda where idvenda=? and idProduto=?";

        setProduto(pProduto);

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, idVenda);
            ps.setInt(2, pProduto.getIdProduto());
            rs   = ps.executeQuery();

            if(rs.next()){

    setIdVenda(idVenda);
    setQtd(rs.getInt(2));
    setValor(rs.getDouble(3));


            }

            }catch(SQLException sqle){
                throw new Exception("Error Instanciar Item Venda "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}


}
