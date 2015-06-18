/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.controle;
import com.afarma.banco.Conexao;
import com.afarma.listas.lProduto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Erick Medeiros
 */
public class Produto {
    private int idProduto;
    private String nome;
    private String descricao;
    private String laboratorio;
    private int quantidade;
    private double valor_venda;
    private int retorno;

    private Connection conn;
    /**
     * @return the nome
     */

    public Produto(){
        setIdProduto(0);
        setNome(null);
        setDescricao(null);
        setLab(null);
        setQtd(0);
        setPreco(0);
        setRetorno(0);
    }

    /**
     * @return the idProduto
     */
    public int getIdProduto() {
        return idProduto;
    }

    /**
     * @param idProduto the idProduto to set
     */
    public void setIdProduto(int idProduto) {
        this.idProduto = idProduto;
    }

    public String getNome() {
        return nome;
    }

    /**
     * @param nome the nome to set
     */
    public void setNome(String pNome) {
        nome = pNome;
    }

    /**
     * @return the descricao
     */
    public String getDescricao() {
        return descricao;
    }

    /**
     * @param descricao the descricao to set
     */
    public void setDescricao(String pDescricao) {
        descricao = pDescricao;
    }

    /**
     * @return the laboratorio
     */
    public String getLab() {
        return laboratorio;
    }

    /**
     * @param laboratorio the laboratorio to set
     */
    public void setLab(String pLab) {
        laboratorio = pLab;
    }

    /**
     * @return the quantidade
     */
    public int getQtdEstoque() {
        return this.quantidade;
    }

    /**
     * @param quantidade the quantidade to set
     */
    public void setQtd(int pQtd) {
        
        this.quantidade = pQtd;
    }

    /**
     * @return the valor_venda
     */
    public double getPreco() {
        return this.valor_venda;
    }

    /**
     * @param valor_venda the valor_venda to set
     */
    public void setPreco(double pValor) {
        this.valor_venda = pValor;
    }

    /**
     * @return the retorno
     */
    public int getRetorno() {
        return retorno;
    }

    /**
     * @param retorno the retorno to set
     */
    public void setRetorno(int retorno) {
        this.retorno = retorno;
    }
    public void incrementaQtdProd(int pQtd) {
          this.quantidade = this.quantidade + pQtd;
    }
    public void decrementaQtdProd(int pQtd) {
          this.quantidade = this.quantidade - pQtd;
    }

public void instanciarProduto(String valor) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select idProduto, nome, descricao, laboratorio, "+
                     "quantidade, valor_venda from listar_produtos where idProduto=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, valor);
            rs   = ps.executeQuery();

            if(rs.next()){
              //  throw new
              //  Exception("Funcionário não encontrado: "+email);
        setIdProduto(rs.getInt(1));
        if( rs.getString(2)!=null)
        setNome(rs.getString(2).toUpperCase());
        if( rs.getString(3)!=null)
        setDescricao(rs.getString(3).toUpperCase());
        if( rs.getString(4)!=null)
        setLab(rs.getString(4).toUpperCase());
        setQtd(rs.getInt(5));
        setPreco(rs.getDouble(6));

            } else {
        setIdProduto(0);
        setNome(null);
        setDescricao(null);
        setLab(null);
        setQtd(0);
        setPreco(0);
            }

            }catch(SQLException sqle){
                throw new Exception("Error Instanciar Produto "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}


public void atualizarProduto() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{
        String sql = "update produto set nome=?, descricao=?, laboratorio=?, " +
                     "quantidade=?, valor_venda=? where idProduto=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            ps.setString(1,getNome().toUpperCase());
            ps.setString(2,getDescricao().toUpperCase());
            ps.setString(3,getLab().toUpperCase());
            ps.setInt(4,getQtdEstoque());
            ps.setDouble(5, getPreco());
            ps.setInt(6, getIdProduto());
            ps.executeUpdate();

            setRetorno(3);

            }catch(SQLException sqle){
                throw new Exception("error Atualizar Produto "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }


}


public void excluirProduto(String produtoId) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        Boolean excluido = true;

        try{
        String sql = "update produto set excluido=? where idProduto=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setBoolean(1, excluido);
            ps.setString(2,produtoId);
            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Excluir Produto "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }


}


public void inserir() throws Exception {

    try{
    if(verificaSeProdutoExiste(getNome())==false){
    inserirProduto();
    pegarId();
    }else{
        pegarId();
        setRetorno(2);
    }
    }catch(SQLException sqle){
                throw new Exception("error Inserir Produto "+sqle);
            }

}


private void inserirProduto() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        Boolean excluir = false;

        try{

            String sql = "insert into produto(nome,descricao,laboratorio, "+
                    "quantidade, valor_venda,excluido)values(?,?,?,?,?,?)";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            ps.setString(1,getNome().toUpperCase());
            ps.setString(2,getDescricao().toUpperCase());
            ps.setString(3,getLab().toUpperCase());
            ps.setInt(4, getQtdEstoque());
            ps.setDouble(5, getPreco());
            ps.setBoolean(6, excluir);
            ps.executeUpdate();
            setRetorno(1);
            }catch(SQLException sqle){

                throw new Exception("error Inserir Produto "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

private void pegarId() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select idProduto from listar_produtos where nome=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1,getNome());
            rs   = ps.executeQuery();

            if(rs.next()){
              setIdProduto(rs.getInt(1));
            }

            }catch(SQLException sqle){
                throw new Exception("Error Pegar Id Produto "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

private Boolean verificaSeProdutoExiste(String valor) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select count(*) from listar_produtos where nome=?";
        int teste;

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1,valor.toLowerCase());
            rs   = ps.executeQuery();

            rs.next();
            return   rs.getInt(1)>0;


            }catch(SQLException sqle){
                throw new Exception("Error Verificar se Produto Existe "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }

}

public  ArrayList<lProduto>   listarProduto(String tipo, String valor) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select idProduto, nome, descricao, laboratorio, quantidade, valor_venda from listar_produtos";
        String filtro="";

        valor = valor.toUpperCase();
        if(tipo.equals("1"))
            filtro = " where idProduto=?";

if(tipo.equals("2"))
            filtro = "where nome like ? order by nome";

if(tipo.equals("3"))
            filtro = "where descricao like ? order by descricao";

if(tipo.equals("4"))
            filtro = "where laboratorio like ? order by laboratorio";

        sql = sql+" "+filtro;

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            if(tipo.equals("2")){
            ps.setString(1, "%" + valor +"%");} else {
            ps.setString(1,valor);
            }

            rs   = ps.executeQuery();

            ArrayList<lProduto> listApoio = new ArrayList<lProduto>();

            while(rs.next()){

                lProduto apoio = new lProduto();

                apoio.setIdProduto(rs.getInt(1));
                apoio.setNome     (rs.getString(2));
                apoio.setDescricao(rs.getString(3));
                apoio.setLab      (rs.getString(4));
                apoio.setQuantidade(rs.getInt(5));
                apoio.setValor_venda(rs.getDouble(6));

                listApoio.add(apoio);
            }


            return listApoio;

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Listar Funcionarios: "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}



}
