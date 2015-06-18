/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.controle;

import com.afarma.banco.Conexao;
import com.afarma.listas.lCliente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


/**
 *
 * @author Erick Medeiros
 */
public class Cliente extends PessoaFisica {
    private int pontos;
    private int id_Cliente;
    private int retorno;
    
    private Connection conn;

    public Cliente(){
        this.id_Cliente = 0;
        this.pontos     = 0;
        this.retorno    = 0;
        setCPF(null);
        setRG(null);
        setIdPessoa(0);
        setNome(null);
        setTelefone(null);
        setEmail(null);
    }

    public int getNumeroPontos() {
        return pontos;
    }
    public void atualizarPontos(int pPontos) {
        this.pontos = pPontos;
    }
    public void zerarPontos() {
      this.pontos = 0;
    }

    /**
     * @return the id_Cliente
     */
    public int getId_Cliente() {
        return this.id_Cliente;
    }

    /**
     * @param id_Cliente the id_Cliente to set
     */
    public void setId_Cliente(int id_Cliente) {
        this.id_Cliente = id_Cliente;
    }

    /**
     * @return the retorno
     */
    public int getRetorno() {
        return this.retorno;
    }

    /**
     * @param retorno the retorno to set
     */
    public void setRetorno(int retorno) {
        this.retorno = retorno;
    }

public void instanciarCliente(String valor) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select  id_Cliente, pontos, idPessoa, nome, telefone, email,"+
                     "cpf, rg from listar_clientes where id_Cliente=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, valor);
            rs   = ps.executeQuery();

            if(rs.next()){
              
        setId_Cliente(rs.getInt(1));
        atualizarPontos(rs.getInt(2));
        setIdPessoa(rs.getInt(3));
        if( rs.getString(4)!=null)
        setNome(rs.getString(4).toUpperCase());
        setTelefone(rs.getString(5));
        if( rs.getString(6)!=null)
        setEmail(rs.getString(6).toLowerCase());
        setCPF(rs.getString(7));
        setRG(rs.getString(8));
            } else {
        setId_Cliente(0);
        atualizarPontos(0);        
        setIdPessoa(0);
        setNome(null);
        setTelefone(null);
        setEmail(null);
        setCPF(null);
        setRG(null);
            }

            }catch(SQLException sqle){
                throw new Exception("Error Instanciar Cliente "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}



public void atualizarCliente() throws Exception {
try{
    pegarIdPessoaAtualizacao();
    atualizarPessoa();
    atualizarPessoaFisica();
    atualCliente();
    setRetorno(3);
    }catch(SQLException sqle){
                throw new Exception("Erro atualizar Cliente "+sqle);
            }
}

private void atualCliente() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

          String  sql = "update cliente set  pontos=?, "+
                        "pessoa_Fisica_pessoa_idPessoa=? where id_Cliente=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, getNumeroPontos());
            ps.setInt(2,getIdPessoa());
            ps.setInt(3, getId_Cliente());
            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Atualizar Cliente "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

private void atualizarPessoaFisica() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{
        String sql = "update pessoa_fisica set  cpf=?, rg=? where pessoa_idPessoa=?";

            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = this.conn.prepareStatement(sql);
            if(getIdPessoa()>0){
            ps.setString(1,getCPF());
            ps.setString(2,getRG());
            ps.setInt(3,getIdPessoa());
            ps.executeUpdate();
            }

            }catch(SQLException sqle){
                throw new Exception("error Atualizar Pessoa Fisica em Cliente "+sqle);
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

                throw new Exception("error Atualizar Pessoa em cliente "+sqle);
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
                throw new Exception("Error Pegar IdPessoa Cliente "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

private void pegarIdPessoaAtualizacao() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select pessoa_Fisica_pessoa_idPessoa from cliente where id_Cliente=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1,getId_Cliente());
            rs   = ps.executeQuery();

            if(rs.next()){
              setIdPessoa(rs.getInt(1));
            }

            }catch(SQLException sqle){
                throw new Exception("Error Pegar IdPessoa Cliente "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

private void pegarId() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select id_Cliente from listar_clientes where email=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1,getEmail());
            rs   = ps.executeQuery();

            if(rs.next()){
              setId_Cliente(rs.getInt(1));
            }

            }catch(SQLException sqle){
                throw new Exception("Error Pegar Id Cliente "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

public void excluirCliente(String valor) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        Boolean excluido = true;


        try{
        String sql = "update cliente set excluido=? where id_Cliente=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            ps.setBoolean(1,excluido);
            ps.setString(2, valor);
            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Excluir Cliente "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }


}

private Boolean verificaSePessoaExiste(String valor) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select count(*) from pessoa where email=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1,valor.toLowerCase());
            rs   = ps.executeQuery();

            rs.next();
            return   rs.getInt(1)>0;


            }catch(SQLException sqle){
                throw new Exception("Error Verificar se Cliente Existe "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }

}

public void inserir() throws Exception {

    try{
    if(verificaSePessoaExiste(getEmail())==false){
    inserirPessoa();
    pegarIdPessoa();
    inserirPessoaFisica();
    inserirCliente();
    pegarId();
    setRetorno(1);
    }else{
        pegarId();
        setRetorno(2);
    }
    }catch(SQLException sqle){
                throw new Exception("error Inserir Cliente "+sqle);
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

                throw new Exception("error Inserir Pessoa "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}


private void inserirPessoaFisica() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{
        String sql = "insert into pessoa_fisica(pessoa_idPessoa, cpf, rg)values(?,?,?)";

            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = this.conn.prepareStatement(sql);
            if(getIdPessoa()>0){
            ps.setInt(1,getIdPessoa());
            ps.setString(2,getCPF());
            ps.setString(3,getRG());
            ps.executeUpdate();
            }

            }catch(SQLException sqle){
                throw new Exception("error Inserir Pessoa Fisica "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

private void inserirCliente() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        Boolean excluir = false;

        try{

          String  sql = "insert into cliente(pontos, pessoa_Fisica_pessoa_idPessoa,excluido)values(?,?,?)";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, getNumeroPontos());
            ps.setInt(2, getIdPessoa());
            ps.setBoolean(3, excluir);
            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Inserir Cliente "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}


public  ArrayList<lCliente>   listar(String tipo, String valor) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select id_Cliente, nome, email, idPessoa from listar_clientes";
        String filtro="";

        valor = valor.toUpperCase();
            

        switch(Integer.parseInt(tipo)){
              case 1: filtro = " where id_Cliente=?";
                      break;
              case 2: filtro = "where CPF=? order by nome";
                      break;
              case 3: filtro = "where nome like ? order by nome";
                      break;            
        }

            

        sql = sql+" "+filtro;

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

          switch(Integer.parseInt(tipo)){

              case 1: ps.setString(1,valor);
                      break;
              case 2: ps.setString(1,valor);
                      break;
              case 3: ps.setString(1, "%" + valor +"%");
                      break;

          }

//            if(tipo.equals("2")){
//            ps.setString(1, "%" + valor +"%");} else {
//            ps.setString(1,valor);
//            }

            rs   = ps.executeQuery();

            ArrayList<lCliente> listApoio = new ArrayList<lCliente>();

            while(rs.next()){

                lCliente apoio = new lCliente();

                apoio.setId_Cliente(rs.getInt(1));
                apoio.setNome         (rs.getString(2));
                apoio.setEmail        (rs.getString(3));
                apoio.setIdPessoa     (rs.getInt(4));

                listApoio.add(apoio);
            }


            return listApoio;

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Listar Funcionarios "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}



}
