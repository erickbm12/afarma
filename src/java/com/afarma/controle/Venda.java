/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.controle;

import com.afarma.banco.Conexao;
import com.afarma.listas.lItemVenda;
import com.afarma.listas.lVendas;
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
public class Venda {
    private int idVenda;
    private Date data;
    private String formaPgto;
    private double desconto;
    private Cliente cliente;
    private Funcionario funcionario;

///////////////////// variaveis de Apoio \\\\\\\\\\\\\\\\\\\\\\\\\\
 /* dataApoio = a retorna do cliente com o Tipo String, apenas na Insercao
  *             é convertida para o tipo Date e atribuidada a variaval DATA;
  *             Quando a data vai do servidor para o cliente o transporte
  *             e pela Variavel dataApoio;
  *apoioIdCli = recebe o id do cliente na janela Busca Cliente para Vender.
  *             e é utilizada por todo o gerenciamento de Vendas;
  *apoioPontos = Quando o cliente e instanciado na janela Busca Cliente para Vender,
  *             essa variavel tem a funcao de armazenar os pontos do cliente antes
  *             de iniciar a venda;
  *nItens      = armazena a quantidade de itens vendido;
  *tItens      = armazena a soma do produto matematico de quantidade e valorVenda.
  *              tambem e utilizada para calcular a pontuacao da sessao;
  *tVendas     = armazena a subtracao de tItens e Desconto;
  *statusVenda = vai gerenciar a janela de Vendas;
  *nPedidosAbertos        = armazenar a quantidade de Vendas aberta de um determinado Cliente;
  *emailFuncPedidosAberto = armazena o e-mail do Funcionario que nao finalizou a venda de um cliente;
  *dataFormatada          = usada para aplicar uma formatacao para uma data;
  *formatarMoeda          = usada para aplicar formatacao de Moeda;
  *
  *Metodos:
  *atualizarDesconto      = utilizado no metodo adicionaItem e removeItem para
  *                         armazenar no DB o desconto do cliente;
  *recuperarDataServidor  = utilizado para recuperar a Data do Servidor e passar
  *                         para o lado cliente;
  * recuperarValorMoedaFormatado = utilizado do lado cliente para imprimir no browse
  *                                do lado cliente os valores no de moeda;
  *fazerPontosDaVenda     = utilizado para calcular a pontuacao da sessa do cliente;
  *                         utilizado no metodo finalizaVenda;
  *fazerDesconto          = verificar a pontuacao do Cliente atraves da variavel
  *                         apoioPontos e retorna 10% ou 0. Utilizado do lado do
  *                         cliente para Imprimir o desconto do Cliente e do lado
  *                         servidor em adicionaItem e removeItem;
  *verificaSeItemExiste   = Itilizado para verificar se o Produto ja exite na Venda.
  *                         Utilizado no metodo adicionaItem;
  *verificaSeExistePedidoAberto =
  *                         utilizado apenas do Lado Cliente. Quando o Funcionario
  *                         Localizar o cliente e chamar jsp:forward page="venda_produtos.jsp"
  *                         quando chegar na janela de Vendas e esse metodo e invocado
  *                         se verdadeiro direciona o Funcionario para janela
  *                         localizar Venda e informa ao Funcionario que o Cliente
  *                         possui uma Venda que nao foi finalizada juntamente com
  *                         o e-mail do Funcionario que efetuou a venda e o ID da mesma;
  *pegarNItensTotal       = utilizado para recuperar o N de Itens e o Total do Itens de
  *                         de uma determinada venda. Utilizado em adionaItem e removeItem;
  *excluirVendasZeradas   = utilizado para veficar se existe Vendas sem Itens,
  *                         se existir as exclue, evitando poluicao do DB.
  *                         utilizado no inserirVenda;
  *inserirVenda           = utilizado do lado Cliente para no inicio de insercao de
  *                         um produto na venda. E verificado se nItens = 0 se for
  *                         esse metodo e invocado;
  *pegarIdVenda           = recupera o id da Venda na sessao;
  *instanciarVenda        = instancia uma venda a partir do ID que vem da Janela
  *                         localizar Venda;
  *finalizarVenda         = utilizado para finalizar uma venda;
  *excluirDetalheVenda    = utilizado para excluir os detalhe de uma venda, quando a
  *                         da exclusao total da venda;
  *excluirVenda           = utilizado para excluir toda a venda;
  *excluir                = utilizdo para chamar os metodos excluirDetalhe e excluirVenda;
  *verificarSeExisteFormaPagamento = utilizado para verificar se existe ou nao uma
  *                                  a forma de pagamento para venda. Esta implementado
  *                                  mas nao foi utilizado;
  *recuperarFormaDePagamento = utilizado para recuperar o indice da forma de pagamento
  *                            para carregar no combox do lado cliente;
  * verificarSeAVendaEstaAbertaDireto = utilizado para na Emissao de Nota Fiscal,
  *                                     Verifica direto se a venda foi Fechada com
  *                                     a forma de Pagamento, se foi emite a NF se não
  *                                     volta para a janela de venda com a mesma
  *                                     instanciada;
  *
  *
  *listarItens            = utilizado para listar os itens na venda;
  *listar                 = utilizado para listar as vendas na janela Busca Venda;
  *
  * 
  * NOTA01: VENDA ABERTA OU COM O STATUS ABERTA = venda salva fisicamente sem forma de pagamento;
  * NOTA02: UMA NOVA VENDA PARA UM CLIENTE ESTA CONDICIONADA A NAO EXISTIR VENDA(S) COM O STATUS ABERTA;
  *
  * NOTA4: O PQ DE NA EMISSAO DA NOTA FISCAL, SE A VENDA NAO FOI FECHADA VOLTAR DIRETO PARA JANELA
  *        DE VENDAS COM A MESMA INSTANCIADA E QUANDO DE UMA NOVA VENDA SE UMA ANTERIOR NAO ESTIVER
  *        FECHADA VAI PARA JANELA DE LOCALIZAR VENDA?
  *        O FUNCIONARIO PODERIA ATRAPALHAR-SE E LANCAR NOVOS PRODUTOS NA VENDA ANTERIOR;
  */


    private String dataApoio;
    private String apoioIdCli;
    private int apoioPontos;
    private int retorno;
    private int nItens;
    private double tItens;
    private double tVenda;
    private String statusVenda;

    private int nPedidosAbertos;
    private String emailFuncPedidosAberto;

///////////////////// fim variaveis de Apoio \\\\\\\\\\\\\\\\\\\\\\\\\\

    private Connection conn;

    SimpleDateFormat dataFormatada = new SimpleDateFormat("dd/MM/yyyy");
    DecimalFormat formatarMoeda = new DecimalFormat("#,##0.00");

    public Venda(){

        this.apoioPontos = 0;
        this.apoioIdCli = "";
        this.dataApoio = "";
        this.desconto = 0;
        this.formaPgto = "00";
        this.idVenda = 0;
        this.retorno = 0;
        this.statusVenda = "";
        this.nItens = 0;
        this.tItens = 0;
        this.tVenda = 0;
        this.nPedidosAbertos = 0;
        this.cliente     = new Cliente();
        this.funcionario = new Funcionario();
        this.emailFuncPedidosAberto = "";

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
     * @return the data
     */
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
     * @return the formaPgto
     */
    public String getFormaPgto() {
        return formaPgto;
    }

    /**
     * @param formaPgto the formaPgto to set
     */
    public void setFormaPgto(String formaPgto) {
        this.formaPgto = formaPgto;
    }

    /**
     * @return the desconto
     */
    public double getDesconto() {
        return desconto;
    }

    /**
     * @param desconto the desconto to set
     */
    public void setDesconto(double desconto) {
        this.desconto = desconto;
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
     * @return the apoioIdCli
     */
    public String getApoioIdCli() {
        return apoioIdCli;
    }

    /**
     * @param apoioIdCli the apoioIdCli to set
     */
    public void setApoioIdCli(String apoioIdCli) {
        this.apoioIdCli = apoioIdCli;
    }

    /**
     * @return the apoioPontos
     */
    public int getApoioPontos() {
        return this.apoioPontos;
    }

    /**apoioPontos
     * @param apoioPontos the apoioPontos to set
     */
    public void setApoioPontos(int apoioPontos) {
        this.apoioPontos = apoioPontos;
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
     * @return the tItens
     */
    public Double gettItens() {
        return tItens;
    }

    /**
     * @param tItens the tItens to set
     */
    public void settItens(Double tItens) {
        this.tItens = tItens;
    }


    /**
     * @return the cliente
     */
    public Cliente getCliente() {
        return cliente;
    }

    /**
     * @return the funcionario
     */
    public Funcionario getFuncionario() {
        return funcionario;
    }

    /**
     * @return the statusVenda
     */
    public String getStatusVenda() {
        return statusVenda;
    }

    /**
     * @param statusVenda the statusVenda to set
     */
    public void setStatusVenda(String statusVenda) {
        this.statusVenda = statusVenda;
    }

    /**
     * @return the tVenda
     */
    public double gettVenda() {
        return tVenda;
    }

    /**
     * @param tVenda the tVenda to set
     */
    public void settVenda(double tVenda) {
        this.tVenda = tVenda;
    }

    /**
     * @return the nPedidosAbertos
     */
    public int getnPedidosAbertos() {
        return nPedidosAbertos;
    }

    /**
     * @return the emailFuncPedidosAberto
     */
    public String getEmailFuncPedidosAberto() {
        return emailFuncPedidosAberto;
    }

    /**
     * @param nPedidosAbertos the nPedidosAbertos to set
     */
    public void setnPedidosAbertos(int nPedidosAbertos) {
        this.nPedidosAbertos = nPedidosAbertos;
    }

    /**
     * @param emailFuncPedidosAberto the emailFuncPedidosAberto to set
     */
    public void setEmailFuncPedidosAberto(String emailFuncPedidosAberto) {
        this.emailFuncPedidosAberto = emailFuncPedidosAberto;
    }

    public void calcularTotal(double pDesconto) {
        this.tVenda = this.tItens - pDesconto;
    }
    public void calculaDesconto(int pPontos) {
        this.desconto = this.tItens*pPontos/100;
    }
    public void setCliente(Cliente pCliente) {
    this.cliente = pCliente;
    }
    public void setFunc(Funcionario pFunc) {
    this.funcionario = pFunc;
    }

public void adicionaItem(Produto pProd, int pQtd, String pPgto) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

   if(this.formaPgto.equals("00")){

   if(verificaSeItemExiste(pProd)==false){

   if(pProd.getQtdEstoque()>pQtd){

        try{



            String  sql = "insert into item_venda(idvenda, "+
                          "idProduto,quantidade, valor_venda)values(?,?,?,?)";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, getIdVenda());
            ps.setInt(2, pProd.getIdProduto());
            ps.setInt(3, pQtd);
            ps.setDouble(4, pProd.getPreco());
            ps.executeUpdate();

            pProd.decrementaQtdProd(pQtd);
            pProd.atualizarProduto();
            pegarNItensTotal();
            calculaDesconto(fazerDesconto(this.apoioPontos));
            calcularTotal(this.desconto);
            atualizarDesconto(this.idVenda, this.desconto);
            
            setRetorno(0);

            }catch(SQLException sqle){
                throw new Exception("error Inserir Detalhe da Venda "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }

   } else {
       setRetorno(36); // quantidade > que a disponivel no Estoque
   }
   } else {
       setRetorno(35); // item ja existe na venda
   }
   } else {
       setRetorno(41); //  Venda Fechada
   }

    }



public void  removeItem(ItemVenda pItem) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        if(this.formaPgto.equals("00")){

        try{

        pItem.getProduto().incrementaQtdProd(pItem.getQtd());
        pItem.getProduto().atualizarProduto();

        String sql = "delete from item_venda where "+
                     " idvenda=? and idProduto=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            ps.setInt(1,pItem.getIdVenda());
            ps.setInt(2,pItem.getProduto().getIdProduto());
            ps.executeUpdate();


            pegarNItensTotal();
            calculaDesconto(fazerDesconto(this.apoioPontos));
            calcularTotal(this.desconto);
            atualizarDesconto(this.idVenda, this.desconto);

            }catch(SQLException sqle){
                throw new Exception("error Excluir Iten Venda "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }

        } else {

            setRetorno(41);// Nao possivel Remover o Item Venda Fechada

        }


}

public void atualizarDesconto(int id_venda, double valor_Desconto) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{



            String  sql = "update venda set desconto=? where idVenda=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setDouble(1, valor_Desconto);
            ps.setInt(2, id_venda);

            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Atualizar Total Desconto "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }

    }

public String recuperarDataServidor(){
  java.util.Date dtaAtual = new java.util.Date();
  return dataFormatada.format(dtaAtual) ;
}

public String recuperarValorMoedaFormatado(double valor){
String temp ="0.00";
    if(valor>0){
    temp = formatarMoeda.format(valor);}
    return temp;
}

public int fazerPontosDaVenda(double totalItens){
 int temp = 0;
 if(totalItens>=10)
  temp = ((int) totalItens/10);
 return temp;
}

public int fazerDesconto(int pontos){
int temp = 0;
   if(pontos>=10)
    temp = 10 ;
return temp;
}

private Boolean verificaSeItemExiste(Produto pProduto) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select count(*) from item_venda where "+
                     "idvenda=? and idProduto=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1,getIdVenda());
            ps.setInt(2, pProduto.getIdProduto());
            rs   = ps.executeQuery();

            rs.next();
            return   rs.getInt(1)>0;


            }catch(SQLException sqle){
                throw new Exception("Error Verificar se Iten Existe nas Vendas "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }

}

public void verificaSeExistePedidoAberto(String pIdCliente) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select lv.idVenda, lv.formPagto , lv.emailFuncionario "+
                     "from listar_venda lv where lv.formPagto is null and "+
                     "lv.cliente_id_cliente=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, pIdCliente);
            rs   = ps.executeQuery();

            rs.last();
            if(rs.getRow()>0){
            this.setnPedidosAbertos(rs.getRow());
            this.idVenda                = rs.getInt(1);
            this.setEmailFuncPedidosAberto(rs.getString(3));
            }


            }catch(SQLException sqle){
                throw new Exception("Error Verificar se Existe Vendas do Cliente Aberta "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }

}

private void pegarNItensTotal() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select nItens, totalItens "+
                     " from listar_venda where idVenda=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, getIdVenda());
            rs   = ps.executeQuery();

           rs.next();
           setnItens(rs.getInt(1));
           settItens(rs.getDouble(2));

            }catch(SQLException sqle){
                throw new Exception("Error pegar N Itens e Total da Venda "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}


public void excluirVendasZeradas() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

            String  sql = "delete v.* from venda v where "+
                          "(select count(*) from item_venda iv "+
                          "where iv.idvenda=v.idVenda)<=0";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.executeUpdate();

            }catch(SQLException sqle){
                throw new Exception("error Excluir Vendas Zeradas "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

public void inserirVenda(Produto pProd, int pQtd) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
if(this.formaPgto.equals("00")){
if(pProd.getQtdEstoque()>pQtd){
        try{

    //////////////////  excluir as vendas sem itens \\\\\\\\\\\\\\\\\\\\\\\\\\

            excluirVendasZeradas();

    //////////////////  FIM excluir as vendas sem itens \\\\\\\\\\\\\\\\\\\\\\\\\\


            setData(new Date(dataFormatada.parse(getDataApoio()).getTime()));
            String  sql = "insert into venda(data, desconto, cliente_id_cliente,"+
                          " funcionario_idfuncionario)values(?,?,?,?)";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setDate(1, new Date(getData().getTime()));
            ps.setDouble(2,0);
            ps.setInt(3, this.cliente.getId_Cliente());
            ps.setInt(4, this.funcionario.getIdFuncionario());
            ps.executeUpdate();
            setRetorno(1);
            pegarIdVenda();

            }catch(SQLException sqle){
                throw new Exception("error Inserir Entrada "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
               } else {
       setRetorno(36); // quantidade > que a disponivel no Estoque
   }
}else{
            setRetorno(41);
}
}

private void pegarIdVenda() throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select idVenda from listar_venda "+
                     "where nItens=0 and funcionario_idfuncionario=? and "+
                     "cliente_id_cliente=? and data=? order by idVenda desc";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, this.funcionario.getIdFuncionario());
            ps.setInt(2, this.cliente.getId_Cliente());
            ps.setDate(3, new Date(getData().getTime()));
            rs   = ps.executeQuery();

           rs.next();
           setIdVenda(rs.getInt(1));

            }catch(SQLException sqle){
                throw new Exception("Error pegar idVenda "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }


}

public  void   instanciarVenda(int idVendaLoc) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;

        String sql = "select idVenda, data, formPagto, cliente_id_cliente, nItens, "+
           "totalItens, funcionario_idfuncionario, totalDesconto from listar_venda "+
           "where idVenda=?";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setInt(1, idVendaLoc);
            rs   = ps.executeQuery();

            while(rs.next()){

            this.statusVenda= "localizar";
            this.idVenda    = rs.getInt(1);
            this.dataApoio  = dataFormatada.format(rs.getDate(2));
            this.formaPgto  = rs.getString(3);
            this.apoioIdCli = rs.getString(4);
            this.cliente.instanciarCliente(rs.getString(4));
            this.nItens     = rs.getInt(5);
            this.tItens     = rs.getDouble(6);
            this.funcionario.instanciarFuncionario(rs.getString(7), 1);
            this.desconto   = rs.getDouble(8);
            this.tVenda     = this.tItens-this.desconto;

            if(this.formaPgto==null)
            this.formaPgto  = "00";
            
            }

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo instanciar Venda "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}

public void finalizarVenda(Cliente pCliente) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;



        try{

            String  sql = "update venda set formPagto=?, desconto=? where idVenda=?";
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, this.formaPgto);
            ps.setDouble(2,this.desconto);
            ps.setInt(3, this.idVenda);
            ps.executeUpdate();

            int restoPontos = 0;
            if(this.apoioPontos>=10)
                restoPontos = this.apoioPontos - 10; else
                restoPontos = this.apoioPontos;

            restoPontos+=fazerPontosDaVenda(this.tItens);

            pCliente.atualizarPontos(restoPontos);
            pCliente.atualizarCliente();

            setRetorno(0);


            }catch(SQLException sqle){
                throw new Exception("error ao Finalizar Venda "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

private  void   excluirDetalheVenda(String idVendaLoc) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;

        Produto excluirProd = new Produto();

        String sql = "select idProduto, quantidade from listar_intensvenda "+
                     " where idvenda = ? ";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, idVendaLoc);
            rs   = ps.executeQuery();

            while(rs.next()){

            excluirProd.instanciarProduto(rs.getString(1));
            excluirProd.incrementaQtdProd(rs.getInt(2));
            excluirProd.atualizarProduto();



            }

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Excluir Venda Detalhe "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}

public  boolean   verificarSeAVendaEstaAbertaDireto(String idVendaLoc) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;


        String sql = "SELECT count(*) from venda v where v.idVenda=? and formPagto is null";

        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, idVendaLoc);
            rs   = ps.executeQuery();
            rs.next();

            return rs.getInt(1)>0;

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Excluir Venda Detalhe "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}

private void excluirVenda(String idVendaLoc) throws Exception {
        PreparedStatement ps = null;
        Connection conect    = null;

        try{

            String  sql = "delete from venda where idVenda=? ";

            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);
            ps.setString(1, idVendaLoc);
            ps.executeUpdate();

            setRetorno(5);

            }catch(SQLException sqle){
                throw new Exception("error Excluir Venda "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps);
            }
}

public void excluir(String idVendaLoc) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;  
if(this.formaPgto.equals("00")){
        try{
        excluirDetalheVenda(idVendaLoc);
        excluirVenda(idVendaLoc);
        this.nItens   = 0;
        this.tItens   = 0;
        this.desconto = 0;
        this.tVenda   = 0;

    }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Excluir Vendas Principal "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
        }else{
         setRetorno(41);// Nao possivel Excluir, Venda Fechada
        }
}

public boolean verificarSeExisteFormaPagamento(){
return this.formaPgto.length()>0;
}

public int recuperarFormaDePagamento(){
int apoio = 0;
if(this.formaPgto.equals("A VISTA"))   apoio = 1;
if(this.formaPgto.equals("EM CHEQUE")) apoio = 2;
if(this.formaPgto.equals("EM CARTAO")) apoio = 3;
return apoio;
}

public  ArrayList<lItemVenda>   listarItens(int valor) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;
        String sql = "select idProduto, quantidade, valor_venda, nome "+
                     "from listar_intensvenda where idvenda=?";


        try{
            this.conn = Conexao.getConnection();
            conect = this.conn;
            ps   = conn.prepareStatement(sql);

            ps.setInt(1,valor);


            rs   = ps.executeQuery();

            ArrayList<lItemVenda> listApoio = new ArrayList<lItemVenda>();

            while(rs.next()){

                lItemVenda apoio = new lItemVenda();

                apoio.setIdProduto    (rs.getInt(1));
                apoio.setQuantidade   (rs.getInt(2));
                apoio.setValor_compra (rs.getDouble(3));
                apoio.setNome         (rs.getString(4));

                listApoio.add(apoio);
            }


            return listApoio;

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Listar Itens Venda "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}

public  ArrayList<lVendas>   listar(int tipo, String valor, String valor2, String CPFL) throws Exception{
        PreparedStatement ps = null;
        Connection conect    = null;
        ResultSet rs         = null;

        String sql = "select idVenda, data, cliente_id_cliente, nome, nItens, "+
                     "totalItens, totalDesconto, funcionario_idfuncionario from listar_venda";
        String filtro="";

        valor = valor.toUpperCase();

        switch(tipo){

            case 1:
                filtro="where idVenda=?";
                break;
            case 2:
                filtro="where nome like ?";
                break;
            case 3:
                filtro="where data between ? and ?";
                break;
            case 4:
                filtro="where ((cpfCliente=?) and (data between ? and ?))";
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
            case 4:
              Date  dta3 = new Date(dataFormatada.parse(valor).getTime());
              Date  dta4 = new Date(dataFormatada.parse(valor2).getTime());
               ps.setString(1, CPFL);
               ps.setDate(2,dta3);
               ps.setDate(3, dta4);
                break;

        }
            rs   = ps.executeQuery();

            ArrayList<lVendas> listApoio = new ArrayList<lVendas>();

            while(rs.next()){

                lVendas apoio = new lVendas();



                apoio.setIdVenda(rs.getInt(1));
                apoio.setDataVenda(dataFormatada.format(rs.getDate(2)));
                apoio.setIdCliente(rs.getInt(3));
                apoio.setNome     (rs.getString(4));
                apoio.setnItens   (rs.getInt(5));
                apoio.settItens   (rs.getDouble(6));
                apoio.setDesconto(rs.getDouble(7));
                apoio.setIdFuncionario(rs.getInt(8));

                listApoio.add(apoio);
            }


            return listApoio;

            }catch(SQLException sqle){
                throw new Exception("Erro no Metodo Listar Vendas "+sqle);
            }finally{
             Conexao.CloseConnection(conn,ps,rs);
            }
}



}
