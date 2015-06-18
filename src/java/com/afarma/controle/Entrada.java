/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.controle;

import com.afarma.banco.Conexao;
import com.afarma.listas.lEntradas;
import com.afarma.listas.lItemEntrada;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.text.DecimalFormat;
import java.util.ArrayList;

/**
 *
 * @author Erick Medeiros
 */
public class Entrada {
    private int IdEntrada;
    private Date data;
    private Fornecedor fornecedor;
    private Funcionario funcionario;
    private String dataApoio;
    private String apoioIdFor;
    private int retorno;
    private int nItens;
    private Double tEntrada;
    private String statusEntrada;




    private Connection conn;

    SimpleDateFormat dataFormatada = new SimpleDateFormat("dd/MM/yyyy");
    DecimalFormat formatarMoeda = new DecimalFormat("#,##0.00");


    public Entrada(){    
    setIdEntrada(0);
    setRetorno(0);
    setDataApoio("");
    setnItens(0);
    settEntrada(0.0);
    setStatusEntrada("");
    this.fornecedor = new Fornecedor();
    this.funcionario= new Funcionario();
    }

    

   public Date getData() {
        return data;
    }

    /**
     * @param data the data to set
     */
    public void setData(Date data) {
        this.data = data;
    }

    /**
     * @return the fornecedor
     */
    public Fornecedor getFornecedor() {
        return fornecedor;
    }

    /**
     * @param fornecedor the fornecedor to set
     */
    public void setFornecedor(Fornecedor fornecedor) {
        this.fornecedor = fornecedor;
    }

    /**
     * @return the funcionario
     */
    public Funcionario getFuncionario() {
        return funcionario;
    }

    /**
     * @param funcionario the funcionario to set
     */
    public void setFuncionario(Funcionario funcionario) {
        this.funcionario = funcionario;
    }

    /**
     * @return the IdEntrada
     */
    public int getIdEntrada() {
        return IdEntrada;
    }

    /**
     * @param IdEntrada the IdEntrada to set
     */
    public void setIdEntrada(int IdEntrada) {
        this.IdEntrada = IdEntrada;
    }

    /**
     * @return the dataApoio
     */
    public String getDataApoio() {
        return dataApoio;
    }

    /**
     * @param dataApoio the dataApoio to set
     */
    public void setDataApoio(String dataApoio) {
        this.dataApoio = dataApoio;
    }

    /**
     * @return the statusEntrada
     */
    public String getStatusEntrada() {
        return statusEntrada;
    }

    /**
     * @param statusEntrada the statusEntrada to set
     */
    public void setStatusEntrada(String statusEntrada) {
        this.statusEntrada = statusEntrada;
    }

    /**
     * @return the apoioIdFor
     */
    public String getApoioIdFor() {
        return apoioIdFor;
    }

    /**
     * @param apoioIdFor the apoioIdFor to set
     */
    public void setApoioIdFor(String apoioIdFor) {
        this.apoioIdFor = apoioIdFor;
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

    /**
     * @return the nItens
     */
    public int getnItens() {
        return nItens;
    }

    /**
     * @param nItens the nItens to set
     */
    public void setnItens(int nItens) {
        this.nItens = nItens;
    }

    /**
     * @return the tEntrada
     */
    public Double gettEntrada() {
        return tEntrada;
    }

    /**
     * @param tEntrada the tEntrada to set
     */
    public void settEntrada(Double tEntrada) {
        this.tEntrada = tEntrada;
    }


    public void adicionaItem(Produto pProduto, int pQtd, double pValor, double pValorVenda) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

   if(verificaSeItemExiste(pProduto)==false){

        try{


                       
            String  sql = "insert into item_entrada(entrada_idEntrada, "+
                          "produto_idProduto,quantidade, valor_compra)values(?,?,?,?)";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, getIdEntrada());
            ps.setInt(2, pProduto.getIdProduto());
            ps.setInt(3, pQtd);
            ps.setDouble(4, pValor);
            ps.executeUpdate();

            pProduto.setPreco(pValorVenda);
            pProduto.incrementaQtdProd(pQtd);
            pProduto.atualizarProduto();

            pegarNItensTotal();
            setRetorno(0);

            }catch(SQLException sqle){
                throw new Exception("error Inserir Detalhe da Entrada "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }

   } else {
       setRetorno(35);
   }

    }


public void  removeItem(ItemEntrada pItem) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

        pItem.getProduto().decrementaQtdProd(pItem.getQtd());
        pItem.getProduto().atualizarProduto();

        String sql = "delete from item_entrada where "+
                     " entrada_idEntrada=? and produto_idProduto=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            ps.setInt(1,pItem.getIdEntrada());
            ps.setInt(2,pItem.getProduto().getIdProduto());
            ps.executeUpdate();
            

            pegarNItensTotal();

            }catch(SQLException sqle){
                throw new Exception("error Excluir Iten Entrada "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }


}

public void inserirEntrada() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

    //////////////////  excluir as entradas sem itens \\\\\\\\\\\\\\\\\\\\\\\\\\

            excluirEntrdasZeradas();

    //////////////////  FIM excluir as entradas sem itens \\\\\\\\\\\\\\\\\\\\\\\\\\

            setData(new Date(dataFormatada.parse(getDataApoio()).getTime()));
            String  sql = "insert into entrada(data, fornecedor_idFornecedor,funcionario_idFuncionario)values(?,?,?)";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setDate(1, new Date(getData().getTime()));
            ps.setInt(2, this.fornecedor.getIdFornecedor());
            ps.setInt(3, this.funcionario.getIdFuncionario());
            ps.executeUpdate();
            setRetorno(1);
            pegarIdEntrada();

            }catch(SQLException sqle){
                throw new Exception("error Inserir Entrada "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

private void pegarIdEntrada() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select idEntrada from listar_entradas "+
                     "where nItens=0 and funcionario_idFuncionario=? and "+
                     "fornecedor_idFornecedor=? and data=? order by idEntrada desc";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, this.funcionario.getIdFuncionario());
            ps.setInt(2, this.fornecedor.getIdFornecedor());
            ps.setDate(3, new Date(getData().getTime()));
            rs   = ps.executeQuery();

           rs.next();
           setIdEntrada(rs.getInt(1));

            }catch(SQLException sqle){
                throw new Exception("Error pegar IdEntrada "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

private void pegarNItensTotal() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select nItens, totalEntrada "+
                     " from listar_entradas where idEntrada=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, getIdEntrada());
            rs   = ps.executeQuery();

           rs.next();
           setnItens(rs.getInt(1));
           settEntrada(rs.getDouble(2));

            }catch(SQLException sqle){
                throw new Exception("Error pegar N Itens e Total da Entrada "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

private Boolean verificaSeItemExiste(Produto pProduto) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select count(*) from item_entrada where "+
                     "entrada_idEntrada=? and produto_idProduto=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1,getIdEntrada());
            ps.setInt(2, pProduto.getIdProduto());
            rs   = ps.executeQuery();

            rs.next();
            return   rs.getInt(1)>0;


            }catch(SQLException sqle){
                throw new Exception("Error Verificar se Iten Existe "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }

}

public String recuperarDataServidor(){
  java.util.Date dtaAtual = new java.util.Date();
  return dataFormatada.format(dtaAtual) ;
}

public String recuperarValorMoedaFormatado(double valor){
String retorno ="0.00";
    if(valor>0){
    retorno = formatarMoeda.format(valor);}
    return retorno;
}

public  ArrayList<lItemEntrada>   listarItens(int valor) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select produto_idProduto, quantidade, valor_compra, nome "+
                     "from listar_intensentrada where entrada_idEntrada=?";


        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            ps.setInt(1,valor);


            rs   = ps.executeQuery();

            ArrayList<lItemEntrada> listApoio = new ArrayList<lItemEntrada>();

            while(rs.next()){

                lItemEntrada apoio = new lItemEntrada();

                apoio.setIdProduto    (rs.getInt(1));
                apoio.setQuantidade   (rs.getInt(2));
                apoio.setValor_compra (rs.getDouble(3));
                apoio.setNome         (rs.getString(4));

                listApoio.add(apoio);
            }


            return listApoio;

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Listar Itens Entrada "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}


public  ArrayList<lEntradas>   listar(int tipo, String valor, String valor2) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;

        String sql = "select idEntrada, data, fornecedor_idFornecedor, nItens, "+
                     "totalEntrada, nome, funcionario_idFuncionario from listar_entradas ";
        String filtro="";

        valor = valor.toUpperCase();

        switch(tipo){

            case 1:
                filtro="where idEntrada=?";
                break;
            case 2:
                filtro="where nome like ?";
                break;
            case 3:
                filtro="where data between ? and ?";
                break;
        }

        sql = sql +" "+filtro;

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

        switch(tipo){

            case 1:
                ps.setString(1,valor);
                break;
            case 2:
                ps.setString(1, "%" + valor +"%");
                break;
            case 3:
              Date  dta1 = new Date(dataFormatada.parse(valor).getTime());
              Date  dta2 = new Date(dataFormatada.parse(valor2).getTime());
               ps.setDate(1,dta1);
               ps.setDate(2, dta2);
                break;
        }
            rs   = ps.executeQuery();

            ArrayList<lEntradas> listApoio = new ArrayList<lEntradas>();

            while(rs.next()){

                lEntradas apoio = new lEntradas();

                apoio.setIdEntrada    (rs.getInt(1));
                apoio.setDataEntrada  (dataFormatada.format(rs.getDate(2)));
                apoio.setIdFornecedor (rs.getInt(3));
                apoio.setnItens       (rs.getInt(4));
                apoio.settTotal       (rs.getDouble(5));
                apoio.setNome         (rs.getString(6));
                apoio.setIdFuncionario(rs.getInt(7));

                listApoio.add(apoio);
            }


            return listApoio;

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Listar Entradas "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}

public void excluirEntrdasZeradas() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

            String  sql = "delete e.* from entrada e where "+
                          "(select count(*) from item_entrada ie "+
                          "where ie.entrada_idEntrada=e.idEntrada)<=0";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Excluir Entrada Zeradas "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

private void excluirEntrada(String idEntradaLoc) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

            String  sql = "delete from entrada where idEntrada=? ";

            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, idEntradaLoc);
            ps.executeUpdate();

            setRetorno(5);

            }catch(SQLException sqle){
                throw new Exception("error Excluir Entrada "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

private  void   excluirDetalheEntrada(String idEntradaLoc) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;

        Produto excluirProd = new Produto();

        String sql = "select produto_idProduto, quantidade from listar_intensentrada "+
                     " where entrada_idEntrada = ? ";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, idEntradaLoc);
            rs   = ps.executeQuery();

            while(rs.next()){

            excluirProd.instanciarProduto(rs.getString(1));
            excluirProd.decrementaQtdProd(rs.getInt(2));
            excluirProd.atualizarProduto();



            }

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Excluir Entradas Detalhe "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}

public void excluir(String idEntradaLoc) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;

    try{
        excluirDetalheEntrada(idEntradaLoc);
        excluirEntrada(idEntradaLoc);
    }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Excluir Entradas Principal "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}


public  void   instanciarEntrada(int idEntradaLoc) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;

        String sql = "select idEntrada, data, fornecedor_idFornecedor, nItens, "+
           "totalEntrada, nome, funcionario_idFuncionario from listar_entradas "+
           "where idEntrada=?";



        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, idEntradaLoc);
            rs   = ps.executeQuery();

            while(rs.next()){

            setStatusEntrada("localizar");
            setIdEntrada(rs.getInt(1));
            setDataApoio(dataFormatada.format(rs.getDate(2)));
            setApoioIdFor(rs.getString(3));
            fornecedor.instanciarFornecedor(rs.getString(3));
            setnItens(rs.getInt(4));
            settEntrada(rs.getDouble(5));
            funcionario.instanciarFuncionario(rs.getString(7), 1);
            }

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo instanciar Entrada "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}




}
