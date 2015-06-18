/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.controle;

import com.afarma.banco.Conexao;
import com.afarma.listas.lFuncionario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;



/**
 *
 * @author Erick Medeiros
 */
public class Funcionario extends PessoaFisica {
    private int idFuncionario;
    private String endereco;
    private String senha;
    private boolean administrador;
    private int retorno;

    /**
     * @return the endereco
     */


    private Connection conn;

 public Funcionario(){
    /*    try{
        this.conn = Conexao.getConnection();
    }catch(Exception e){
        throw new Exception("Error Inicio Conexao: "+":\n"+e.getMessage());
    }*/
             setIdFuncionario(0);
             setEndereco(null);
             setSenha(null);
             setPerfilAdm(false);
             setIdPessoa(0);
             setNome(null);
             setTelefone(null);
             setEmail(null);
             setCPF(null);
             setRG(null);
             setRetorno(0);
}

    public String getEndereco() {
        return endereco;
    }

    /**
     * @param endereco the endereco to set
     */
    public void setEndereco(String pEndereco) {
        endereco = pEndereco;
    }

    /**
     * @return the senha
     */
    public String getSenha() {
        return senha;
    }

    /**
     * @param senha the senha to set
     */
    public void setSenha(String pSenha) {
        senha = pSenha;
    }

    /**
     * @return the administrador
     */
    public boolean getPerfilAdm() {
        return administrador;
    }

    /**
     * @param administrador the administrador to set
     */
    public void setPerfilAdm(boolean pAdm) {
        administrador = pAdm;
    }


        public int getIdFuncionario() {
        return idFuncionario;
    }


    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
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



    public boolean validaUsuario(String email, String senha)throws Exception {

        boolean ret = false;
        try{
        this.fazerLogin(email, senha);
        if (this.senha != null ){
            ret = true;
        }
        }catch(SQLException sqle){
                throw new Exception("error valida usuario "+sqle);
            }

        return ret;

    }


 private void fazerLogin(String email, String senha) throws Exception {
        PreparedStatement ps = null;
        Connection conect      = null;
        ResultSet rs         = null;
        String sql = "select email, senha, administrador "+
                    "from listar_funcionarios where email=? and senha =?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, senha);

            rs   = ps.executeQuery();

            if(rs.next()){
              //  throw new
              //  Exception("Funcionário não encontrado: "+email);
            

             setEmail(rs.getString(1));
             setSenha(rs.getString(2));
             setPerfilAdm(rs.getBoolean(3));

            } else {
             setEmail(null);
             setSenha(null);
             setPerfilAdm(false);
            }
             
            }catch(SQLException sqle){
                throw new Exception("error fazer login "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }

    }

public void instanciarFuncionario(String valor, int busca) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql =  "select   idFuncionario, endereco, senha, administrador, idPessoa,"+
                      "nome, telefone, email, cpf, rg "+
                      "from listar_funcionarios ";
        String filtro = "";

        switch(busca){
            case 1:
                filtro=" where idFuncionario=?";
                break;
            case 2:
                filtro=" where email=?";
                break;
        }

        sql = sql + filtro;

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, valor);
            rs   = ps.executeQuery();

            if(rs.next()){
              
             setIdFuncionario(rs.getInt(1));
             if( rs.getString(2)!=null)
             setEndereco(rs.getString(2).toUpperCase());
             if( rs.getString(3)!=null)
             setSenha(rs.getString(3).toUpperCase());
             setPerfilAdm(rs.getBoolean(4));
             setIdPessoa(rs.getInt(5));
             if( rs.getString(6)!=null)
             setNome(rs.getString(6).toUpperCase());
             setTelefone(rs.getString(7));
             setEmail(rs.getString(8).toLowerCase());
             setCPF(rs.getString(9));
             setRG(rs.getString(10));



            } else {
                
             setIdFuncionario(0);
             setEndereco(null);
             setSenha(null);
             setPerfilAdm(false);
             setIdPessoa(0);
             setNome(null);
             setTelefone(null);
             setEmail(null);
             setCPF(null);
             setRG(null);
            }

            }catch(SQLException sqle){
                throw new Exception("Error Instanciar Funacionário "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}


public void atualizarFuncionario() throws Exception {
    try{
    pegarIdPessoaAtualizacao();
    atualizarPessoa();
    atualizarPessoaFisica();
    atualFuncionario();
    setRetorno(3);
    }catch(SQLException sqle){
                throw new Exception("Erro atualizarFuncionario "+sqle);
            }
}

public void excluirFuncionario(String valor) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        Boolean excluido = true;


        try{
        String sql = "update funcionario set excluido=? where idFuncionario=?";
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
    inserirPessoaFisica();
    inserirFuncionario();
    pegarId();
    setRetorno(1);
    }else{
        setRetorno(2);
        setRetorno(2);
    }
    }catch(SQLException sqle){
                throw new Exception("Erro Inserir "+sqle);
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
                throw new Exception("Error Pegar IdPessoa "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

private void pegarIdPessoaAtualizacao() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select pessoa_Fisica_pessoa_idPessoa from funcionario where idFuncionario=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1,getIdFuncionario());
            rs   = ps.executeQuery();

            if(rs.next()){
              setIdPessoa(rs.getInt(1));
            }

            }catch(SQLException sqle){
                throw new Exception("Error Pegar IdPessoa "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

private void pegarId() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select idFuncionario from listar_funcionarios where email=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1,getEmail());
            rs   = ps.executeQuery();

            if(rs.next()){
              setIdFuncionario(rs.getInt(1));
            }

            }catch(SQLException sqle){
                throw new Exception("Error Pegar Id Funcionario "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
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
                throw new Exception("Error Verificar se Funcionario Existe "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
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

private void inserirFuncionario() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        Boolean excluir = false;

        try{

          String  sql = "insert into funcionario(endereco, senha, administrador, "+
                        "pessoa_Fisica_pessoa_idPessoa, excluido)values(?,?,?,?,?)";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, getEndereco().toUpperCase());
            ps.setString(2,getSenha().toUpperCase());
            ps.setBoolean(3,getPerfilAdm());
            ps.setInt(4, getIdPessoa());
            ps.setBoolean(5, excluir);
            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Inserir Funcionário "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}


/*
public void atualizar() throws Exception {

    try{
    atualizarPessoa();
    atualizarPessoaFisica();
    atualFuncionario();
    }catch(SQLException sqle){
                throw new Exception("Error Atualizar "+sqle);
            }

}*/

private void atualizarPessoa() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

            String sql = "update pessoa set nome=?,telefone=?,email=? where idPessoa=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            ps.setString(1,getNome());
            ps.setString(2,getTelefone());
            ps.setString(3,getEmail());
            ps.setInt(4, getIdPessoa());
            ps.executeUpdate();

            }catch(SQLException sqle){

                throw new Exception("error Atualizar Pessoa "+sqle);
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
                throw new Exception("error Atualizar Pessoa Fisica "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}


private void atualFuncionario() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

          String  sql = "update funcionario set endereco=?, senha=?, administrador=?, "+
                        "pessoa_Fisica_pessoa_idPessoa=? where idFuncionario=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, getEndereco());
            ps.setString(2,getSenha());
            ps.setBoolean(3,getPerfilAdm());
            ps.setInt(4, getIdPessoa());
            ps.setInt(5, getIdFuncionario());
            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Atualizar Funcionário "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

public  ArrayList<lFuncionario>   listarFuncionario(String tipo, String valor) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select idFuncionario, nome, email, idPessoa from listar_funcionarios";
        String filtro="";

        valor = valor.toUpperCase();
        if(tipo.equals("1"))
            filtro = " where idFuncionario=?";

if(tipo.equals("2"))
            filtro = "where nome like ? order by nome";

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

            ArrayList<lFuncionario> listFuncionario = new ArrayList<lFuncionario>();

            while(rs.next()){

                lFuncionario func = new lFuncionario();

                func.setIdFuncionario(rs.getInt(1));
                func.setNome         (rs.getString(2));
                func.setEmail        (rs.getString(3));
                func.setIdPessoa     (rs.getInt(4));

                listFuncionario.add(func);
            }


            return listFuncionario;

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Listar Funcionarios: "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}


}

