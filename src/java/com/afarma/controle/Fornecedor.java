/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.controle;

import com.afarma.banco.Conexao;
import com.afarma.listas.lFornecedor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
/**
 *
 * @author Erick Medeiros
 */
public class Fornecedor extends PessoaJuridica {
    private String contato;
    private int idFornecedor;
    private int retorno;

    private Connection conn;

    public Fornecedor(){

        setIdFornecedor(0);
        setContato(null);
        setCNPJ(null);
        setRazaoSocial(null);
        setIdPessoa(0);
        setNome(null);
        setTelefone(null);
        setEmail(null);
        setRetorno(0);

    }

    public String getContato() {
        return contato;
    }
    public void setContato(String pContato) {
        contato = pContato;
    }

    /**
     * @return the idFornecedor
     */
    public int getIdFornecedor() {
        return idFornecedor;
    }

    /**
     * @param idFornecedor the idFornecedor to set
     */
    public void setIdFornecedor(int idFornecedor) {
        this.idFornecedor = idFornecedor;
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

public void instanciarFornecedor(String idFornecedor) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select  idFornecedor, contato, idPessoa, nome, telefone, email,"+
                     "cnpj, razaoSocial from listar_fornecedor where idFornecedor=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idFornecedor));
            rs   = ps.executeQuery();

            if(rs.next()){
              //  throw new
              //  Exception("Fornecedor não encontrado: "+email);
        setIdFornecedor(rs.getInt(1));
        if( rs.getString(2)!=null)
        setContato(rs.getString(2).toUpperCase());
        setIdPessoa(rs.getInt(3));
        if( rs.getString(4)!=null)
        setNome(rs.getString(4).toUpperCase());
        setTelefone(rs.getString(5));
        if( rs.getString(6)!=null)
        setEmail(rs.getString(6).toLowerCase());
        setCNPJ(rs.getString(7));
        if( rs.getString(8)!=null)
        setRazaoSocial(rs.getString(8).toUpperCase());

            } else {
        setIdFornecedor(0);
        setContato(null);
        setIdPessoa(0);
        setNome(null);
        setTelefone(null);
        setEmail(null);
        setCNPJ(null);
        setRazaoSocial(null);
            }

            }catch(SQLException sqle){
                throw new Exception("Error Instanciar Fornecedor "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}


public void atualizarFornecedor() throws Exception {
try{
    pegarIdPessoaAtualizacao();
    atualizarPessoa();
    atualizarPessoaJuridica();
    atualFornecedor();
    setRetorno(3);
    }catch(SQLException sqle){
                throw new Exception("Erro atualizar Fornecedor "+sqle);
            }
}

private void atualFornecedor() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

          String  sql = "update fornecedor  set  contato=?, "+
                        "pessoa_Juridica_pessoa_idPessoa=? where idFornecedor=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, getContato().toUpperCase());
            ps.setInt(2,getIdPessoa());
            ps.setInt(3, getIdFornecedor());
            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Atualizar Fornecedor "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

private void atualizarPessoaJuridica() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{
        String sql = "update pessoa_juridica set cnpj=?, razaoSocial=? where pessoa_idPessoa=?";

            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = this.conn.prepareStatement(sql);
            if(getIdPessoa()>0){
            ps.setString(1,getCNPJ());
            ps.setString(2,getRazaoSocial().toUpperCase());
            ps.setInt(3,getIdPessoa());
            ps.executeUpdate();
            }

            }catch(SQLException sqle){
                throw new Exception("error Atualizar Pessoa Juridica em Fornecedor "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

private void atualizarPessoa() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

            String sql = "update pessoa set nome=?,telefone=?,email=? where idPessoa=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            ps.setString(1,getNome().toUpperCase());
            ps.setString(2,getTelefone());
            ps.setString(3,getEmail().toLowerCase());
            ps.setInt(4, getIdPessoa());
            ps.executeUpdate();

            }catch(SQLException sqle){

                throw new Exception("error Atualizar Pessoa em Fornecedor "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}


private void pegarIdPessoa() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select idPessoa from pessoa where email=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1,getEmail());
            rs   = ps.executeQuery();

            if(rs.next()){
              setIdPessoa(rs.getInt(1));
            }

            }catch(SQLException sqle){
                throw new Exception("Error Pegar IdPessoa Fornecedor "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

private void pegarIdPessoaAtualizacao() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select pessoa_Juridica_pessoa_idPessoa from fornecedor where idFornecedor=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1,getIdFornecedor());
            rs   = ps.executeQuery();

            if(rs.next()){
              setIdPessoa(rs.getInt(1));
            }

            }catch(SQLException sqle){
                throw new Exception("Error Pegar IdPessoa Fornecedor Atualizacao "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

private void pegarId() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select idFornecedor from listar_fornecedor where email=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1,getEmail());
            rs   = ps.executeQuery();

            if(rs.next()){
              setIdFornecedor(rs.getInt(1));
            }

            }catch(SQLException sqle){
                throw new Exception("Error Pegar Id Fornecedor "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

public void excluirFornecedor(String valor) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        Boolean excluido = true;


        try{
        String sql = "update fornecedor set excluido=? where idFornecedor=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            ps.setBoolean(1,excluido);
            ps.setString(2, valor);
            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Excluir Fornecedor "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }


}


public void inserir() throws Exception {

    try{
    if(verificaSePessoaExiste(getEmail())==false){
    inserirPessoa();
    pegarIdPessoa();
    inserirPessoaJuridica();
    inserirFornecedor();
    pegarId();
    setRetorno(1);
    }else{
        setRetorno(2);
        setRetorno(2);
    }
    }catch(SQLException sqle){
                throw new Exception("error Inserir Cliente "+sqle);
            }

}


 private Boolean verificaSePessoaExiste(String valor) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select count(*) from pessoa where email=?";
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
                throw new Exception("Error Verificar se Fornecedor Existe "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }

}


private void inserirPessoa() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

            String sql = "insert into pessoa(nome,telefone,email)values(?,?,?)";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            ps.setString(1,getNome().toUpperCase());
            ps.setString(2,getTelefone());
            ps.setString(3,getEmail().toLowerCase());
            ps.executeUpdate();

            }catch(SQLException sqle){

                throw new Exception("error Inserir Pessoa em Fornecedor "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}



private void inserirPessoaJuridica() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{
        String sql = "insert into pessoa_juridica(pessoa_idPessoa, cnpj, razaoSocial)values(?,?,?)";

            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = this.conn.prepareStatement(sql);
            if(getIdPessoa()>0){
            ps.setInt(1,getIdPessoa());
            ps.setString(2,getCNPJ());
            ps.setString(3,getRazaoSocial().toUpperCase());
            ps.executeUpdate();
            }

            }catch(SQLException sqle){
                throw new Exception("error Inserir Pessoa Juridica "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

private void inserirFornecedor() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        Boolean excluir = false;

        try{

          String  sql = "insert into fornecedor(contato, pessoa_Juridica_pessoa_idPessoa,excluido)values(?,?,?)";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, getContato().toUpperCase());
            ps.setInt(2, getIdPessoa());
            ps.setBoolean(3, excluir);
            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Inserir Fornecedor "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}



public  ArrayList<lFornecedor>   listar(String tipo, String valor) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select idFornecedor, nome, email, idPessoa, razaoSocial from listar_fornecedor";
        String filtro="";

        valor = valor.toUpperCase();

        switch (Integer.parseInt(tipo)){
            case 1:filtro = " where idFornecedor=?";
                   break;
            case 2:filtro = " where cnpj=?";
                   break;
            case 3:filtro = "where nome like ? order by nome";
                   break;
            case 4:filtro = "where razaoSocial like ? order by nome";
                   break;
        }



        sql = sql+" "+filtro;

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            if((tipo.equals("1"))||(tipo.equals("2")))
            {
            ps.setString(1,valor);
            } else {
            ps.setString(1, "%" + valor +"%");
            }



            rs   = ps.executeQuery();

            ArrayList<lFornecedor> listApoio = new ArrayList<lFornecedor>();

            while(rs.next()){

                lFornecedor apoio = new lFornecedor();

                apoio.setIdFornecedor(rs.getInt(1));
                apoio.setNome         (rs.getString(2));
                apoio.setEmail        (rs.getString(3));
                apoio.setIdPessoa     (rs.getInt(4));
                apoio.setRazaoSocial  (rs.getString(5));

                listApoio.add(apoio);
            }


            return listApoio;

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Listar Fornecedores "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}


}
