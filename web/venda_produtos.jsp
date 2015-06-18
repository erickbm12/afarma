<%-- 
    Document   : venda_produtos
    Created on : 05/06/2015, 19:32:46
    Author     : Erick Medeiros
--%>


<script type="text/javascript" src="js/validaCadastros.js"></script>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*,com.afarma.listas.*"%>
<jsp:useBean id="cliente" scope="page" class="com.afarma.controle.Cliente"/>
<jsp:useBean id="produto" scope="page" class="com.afarma.controle.Produto"/>
<jsp:useBean id="funcionario" scope="page" class="com.afarma.controle.Funcionario"/>
<jsp:useBean id="itenVenda" scope="page" class="com.afarma.controle.ItemVenda"/>
<jsp:useBean id="venda" scope="session" class="com.afarma.controle.Venda"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%

     Boolean logado = (Boolean) session.getAttribute("Logado");

     if(logado != null){
        if(!logado){
%>
        <jsp:forward page="logar.jsp" />
<%
        }else{

////////////////////////////// verifica se e uma nova venda ou a instanciar de uma Existente \\\\\\\\\\\\\\\\\\\\\\\\
     if(((venda.getStatusVenda()==null)&&((venda.getStatusVenda()!="nova")||(venda.getStatusVenda()!="localizar")))){
     %>
     <jsp:forward page="busca_cliente_venda.jsp" />
     <%  
  }
////////////////////////////// fim verifica se e uma nova venda ou a instanciar de uma Existente \\\\\\\\\\\\\\\\\\\\\\\\
     String acao = "";
     acao        = request.getParameter("acao");

     /* retorno da Busca de Produto */
     String idProduto      = "";
     String descProduto    = "";
     String valorVenda     = "";
     String estoque        = "";

     String idVendaLoc     = "";
     String formaPagamento = "";
////////////////////////////// variavel que vai ou nao habilitar o combobox com as formas de pagamento e indice \\\\\\\\\\\\\\\\\\\\\\\\
     String habilitarFpg   = " ";
     int indiceFpg      = 0;
////////////////////////////// fim variavel que vai ou nao habilitar o combobox com as formas de pagamento e indice \\\\\\\\\\\\\\\\\\\\\\\\



     idProduto    = request.getParameter("id_produto");
     descProduto  = request.getParameter("nome_prodLoc");
     valorVenda   = request.getParameter("valorVenda_prodLoc");
     estoque      = request.getParameter("estoque_prodLoc");

     idVendaLoc      = request.getParameter("id_venda");

////////////////////////////// captura a forma de pagamento \\\\\\\\\\\\\\\\\\\\\\\\
     if(((request.getParameter("fpg")!="00")&&(request.getParameter("fpg")!=null))){
     formaPagamento  = request.getParameter("fpg");
     }
     if(((venda.getFormaPgto()!="00")&&(venda.getFormaPgto()!=null))){
     formaPagamento = venda.getFormaPgto();
     }
////////////////////////////// captura a forma de pagamento \\\\\\\\\\\\\\\\\\\\\\\\



      
     if(venda.getApoioIdCli()!=null)
     cliente.instanciarCliente(venda.getApoioIdCli());

     funcionario.instanciarFuncionario((String)session.getAttribute("usuario"), 2);
     produto.instanciarProduto(idProduto);

    if(acao == null){
        acao = new  String();
    }

     /////////////// VERIFICAR SE EXISTE VENDAS ABERTAS PARA O CLIENTE \\\\\\\\\\\\\\\\\\

     if(((venda.getnItens()==0)&&(venda.getStatusVenda().equals("nova")))){
     venda.verificaSeExistePedidoAberto(venda.getApoioIdCli());
     if(venda.getnPedidosAbertos()>0){
     %>
      <jsp:forward page="busca_venda.jsp"/>
     <%
         }
     }

     /////////////// FIM VERIFICAR SE EXISTE VENDAS ABERTAS PARA O CLIENTE \\\\\\\\\\\\\\\\\\

     //////////////////////////////// INICIO VENDA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
     if(acao.equals("1")){    

     
     if(cliente.getNome()==null){
     out.println("<SCRIPT language='JavaScript'>");
     out.println("alert('Cliente Não Encontrado! Operação cancelada!');");
     out.println("</SCRIPT>");
     %>
     <jsp:forward page="busca_cliente_venda.jsp" />
     <%  
         }else
     if(produto.getNome()==null){
     out.println("<SCRIPT language='JavaScript'>");
     out.println("alert('Produto Não Encontrado! Operação cancelada!');");
     out.println("</SCRIPT>");     
     }else{


    int quantidade   = 0;
    quantidade   = Integer.parseInt(request.getParameter("quantidade_produto"));

         if(venda.getnItens()==0){
         venda.setDataApoio(request.getParameter("data_venda"));
         venda.setCliente(cliente);
         venda.setFunc(funcionario);
         venda.inserirVenda(produto,quantidade);

    if(venda.getRetorno()==34){
     out.println("<SCRIPT language='JavaScript'>");
     out.println("alert('Quantidade vendida MAIOR que a disponível no Estoque! Operação cancelada!');");
     out.println("</SCRIPT>");
     }
         }         


         venda.adicionaItem(produto, quantidade, "preferi nao Usar");
         // NOTA: SE USAR A FORMA DE PAGAMENTO NO METODO ACIMA, NAO SERA POSSIVEL VALIDAR AS MANUTENCOES: ADICIONAR ITEM, EXCLUIR ITEM;

         if(venda.getRetorno()==35){
             out.println("<SCRIPT language='JavaScript'>");
             out.println("alert('Produto já Existe na Venda! Não foi possível Inserir!');");
             out.println("</SCRIPT>");
             }

    if(venda.getRetorno()==36){
     out.println("<SCRIPT language='JavaScript'>");
     out.println("alert('Quantidade vendida MAIOR que a disponível no Estoque! Operação cancelada!');");
     out.println("</SCRIPT>");
     }

     if(venda.getRetorno()==41){
     out.println("<SCRIPT language='JavaScript'>");
     out.println("alert('Venda Finalizada! Não é possível Inserir Novos Itens!');");
     out.println("</SCRIPT>");
     venda.setRetorno(0);
     }

         }       
       }

//////////////////////////////// FIM VENDA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//////////////////////////////// EXCLUIR VENDA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

     if(acao.equals("2")){

         if(idVendaLoc!=null)
         venda.excluir(idVendaLoc);

    if(venda.getRetorno()==41){
     out.println("<SCRIPT language='JavaScript'>");
     out.println("alert('Venda Finalizada! Não é possível Excluir a Venda!');");
     out.println("</SCRIPT>");
     venda.setRetorno(0);
     }
         }

//////////////////////////////// FIM EXCLUIR VENDA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//////////////////////////////// INSTANCIAR VENDA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
     if(acao.equals("3")){
         
         if(idVendaLoc!=null)
         venda.instanciarVenda(Integer.parseInt(idVendaLoc));
         cliente.instanciarCliente(Integer.toString(venda.getCliente().getId_Cliente()));

        if(venda.getFormaPgto()==null)
         venda.setApoioPontos(cliente.getNumeroPontos());
         
         }

//////////////////////////////// FIM INSTANCIAR VENDA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//////////////////////////////// FINALIZAR VENDA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

     if(acao.equals("4")){

        if(((formaPagamento!="00")&&(formaPagamento!=null))){

          venda.setFormaPgto(formaPagamento);  
          venda.finalizarVenda(cliente);

            }else{
     out.println("<SCRIPT language='JavaScript'>");
     out.println("alert('Favor Informar a Forma de Pagamento!Operação Cancelada!');");
     out.println("</SCRIPT>");
            }


         }

//////////////////////////////// FIM FINALIZAR VENDA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

//////////////////////////////// Excluir Item VENDA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
     if(acao.equals("34")){
     itenVenda.instanciarItenVenda(venda.getIdVenda(), produto);
     venda.removeItem(itenVenda);
    if(venda.getRetorno()==41){
     out.println("<SCRIPT language='JavaScript'>");
     out.println("alert('Venda Finalizada! Não é possível Excluir o Iten!');");
     out.println("</SCRIPT>");
     venda.setRetorno(4);
     }
         }
//////////////////////////////// FIM Excluir Item VENDA \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

///////////////////////////////// DEFINIR HABILITACAO DO COMBOBOX FORMA DE PAGAMENTO \\\\\\\\\\\\\\\\\\\\\\\\\\\\
   if(((venda.getFormaPgto()!="00")&&(venda.getFormaPgto()!=null))){
       habilitarFpg = "disabled='true'";
       indiceFpg    = venda.recuperarFormaDePagamento();
   }
///////////////////////////////// FIM DEFINIR HABILITACAO DO COMBOBOX FORMA DE PAGAMENTO \\\\\\\\\\\\\\\\\\\\\\\\\\\\

     %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::VENDA DE PRODUTOS::</title>


        <style type="text/css">
<!--
body {
	background-color: #00CACE;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style3 {
	font-size: 10px;
	font-weight: bold;
	color: #FFFFFF;
}
.style4 {color: #FFFFFF}

.inputstyle {
	font-family: tahoma;
	font-size: 14px;
	font-weight: normal;
	color: #0000FF;
	background-color: #E2EDEB;
	border: 1px solid #0000FF;
}

.innputstyle {
	font-family: tahoma;
	font-size: 09px;
	font-weight: normal;
	color: #0000FF;
	background-color: #E2EDEB;
	border: 1px solid #0000FF;
}


a:link {
	color: #FFFFFF;
	font-family: tahoma;
	font-size: 10px;
	font-weight: normal;
	text-decoration: none;

}
a:visited {
	color: #FFFFFF;
	font-family: tahoma;
	font-size: 10px;
	font-weight: normal;
	font-style: normal;
	text-decoration: none;

}

a:hover {
	color: #0000FF;
	font-family: tahoma;
	font-size: 10px;
	font-weight: normal;
	font-style: normal;
	line-height: normal;
	font-variant: normal;
	text-transform: none;
	text-decoration: underline;
}

a.a:link {
	font-family: tahoma;
	font-size: 10px;
	font-weight: normal;
	color: 632210;
	text-decoration: underline;
}
.dr {
	font-family: tahoma;
	font-size: 10px;
	font-weight: bolder;
	color: #FFFFFF;
}
.div_menu {
	font-family: tahoma;
	font-size: 10px;
	font-weight: bolder;
	color: #FFFFFF;
}
.formato_label {
	color: #000099;
	font-weight: bold;
	font-size: 16px;
}
.style2 {	color: #0033FF;
	font-weight: bold;
}
-->
        </style>
 </head>
 <body  onload="setarEdit('id_produto')">

<table width="776" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="151">&nbsp;</td>
    <td width="159">&nbsp;</td>
    <td width="158">&nbsp;</td>
    <td width="301">&nbsp;</td>
    <td width="8">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4" background="Drag to a file to choose it."><div align="center"><img src="IMG/Banner_topo.jpg" width="776" height="200" /></div>
    <div align="center"></div></td>
    <td><img src="IMG/Pedaco_Banner_topo.jpg" width="8" height="200" /></td>
  </tr>
  <tr>
    <td bgcolor="#02C6CE">&nbsp;</td>
    <td bgcolor="#02C6CE">&nbsp;</td>
    <td bgcolor="#02C6CE">&nbsp;</td>
    <td bgcolor="#02C6CE">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="30" colspan="5" bgcolor="#01A7D9"><div align="center"><a href="link_cadastros.jsp">JANELA PRINCIPAL</a>&nbsp; &nbsp;<a href="index.jsp">HOME</a>&nbsp; &nbsp; <a href="logout.jsp">Logout</a></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td bgcolor="#00CACE">&nbsp;</td>
    <td colspan="2" bgcolor="#00CACE"><div align="center"></div></td>
    <td bgcolor="#00CACE">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5" valign="top"><div align="center"><fieldset>
    <legend class="formato_label"> Venda de Produtos: </legend>
    <legend class="formato_label"></legend>
    <form name="formEntradaProdutos" method="post" onSubmit="return validaInsercaoVenda(this);" action="venda_produtos.jsp?acao=1">

        <table width="579" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="110">&nbsp;</td>
            <td width="84" class="formato_label">&nbsp;</td>
            <td width="241" align="center">
                            <a href="busca_venda.jsp"><font size="4" color="#000000">BUSCA VENDA</font></a><br/>
                            <a href="busca_cliente_venda.jsp"><font size="4" color="#000000">NOVA VENDA</font></a>
            </td>
            <td width="144" align="center">&nbsp;</td>
          </tr>

          <tr>
            <td><div align="right"><span class="formato_label">ID Venda:</span></div>

            </td>

            <td align="center" class="formato_label"><div align="left">
                  <input name="id_venda" type="text" id="id_venda" size="10"
                         style="text-align:right"
                         maxlength="10" readonly="true"
                         value=<%out.write(String.format("%03d",venda.getIdVenda()));%>>
                </div></td>
                <td align="center" ><div align="right">
                        <span class="formato_label">Data:</span></div></td>
                        <td align="center" class="formato_label"><div align="left">
                  <input name="data_venda" type="text" id="data_venda" size="10"
                         maxlength="10"  onkeypress="mascara(this, dataMascara);"
                         onblur="doDate(this.value, 5);"
                         value=<%=venda.getDataApoio()%>>
                </div></td>
          </tr>

          <tr>
            <td><div align="right"><span class="formato_label">ID Cliente:</span></div></td>
            <td align="center" class="formato_label"><div align="left">
            <input name="id_cliente" type="text" id="id_cliente" size="10"
            style="text-align:right"
            maxlength="10" readonly="true"
            value=<%out.write(String.format("%03d",cliente.getId_Cliente()));%>>
            </div></td>
            <td align="center" colspan="3"><div align="left">
            <span class="formato_label"><%=cliente.getNome()%></span>
            </div></td>            
          </tr>

          <tr>
           <td><div align="right"><span class="formato_label">ID Produto:</span></div></td>

            <td align="center" class="formato_label"><div align="left">
            <input name="id_produto" type="text" id="id_produto" size="10"
            style="text-align:right"
            maxlength="10" onKeyPress="mascara(this,soNumeros);"
            value=<%
                        if(idProduto!=null){
                         out.write(String.format("%03d",Integer.parseInt(idProduto)));
                            }else{
                            out.write("0");
                            }
            

            %>   >
            </div></td>

            <td align="center" colspan="1"><div align="left">
            <span class="formato_label">Quant.: </span>
            <input name="quantidade_produto" type="text" id="quantidade_produto" size="5"
            style="text-align:right"
            maxlength="10" onKeyPress="mascara(this,soNumeros);"
            value="0"/>

                     <span class="formato_label">  Valor: </span>
                     <span class="formato_label"> <% if(valorVenda!=null){
                                                  out.write(valorVenda);} else {
                                                  out.write("0.00");} %> </span>&nbsp;&nbsp;
                     <span class="formato_label">  Est.: </span>
                     <span class="formato_label"> <% if(estoque!=null){
                     out.write(String.format("%03d",Integer.parseInt(estoque)));}
                     else{out.write("000");}%></span>

            </div>
            </td>
            <td><div align="center">
              <input class="innputstyle" type="submit"  name="Submit"        value="      Inserir          " title="Clique para Inserir o Produto na Entrada" onclick="enviar(this.form)"/><br/>
              <input class="innputstyle" type="button"  name="loc_produto"   value=" Localizar Produto " title="Clique para Localizar um Produto e Inserir na Venda" onclick="buscaProdutoVenda();"/><br/>
              <input class="innputstyle" type="button"  name="finalizar"     value="  Finalizar Venda  " title="Clique para Finalizar a Venda" onclick="finalizarVenda('<%out.write(String.format("%03d",venda.getIdVenda()));%>',<%= venda.getnItens() %>,document.getElementById('fpg').value);"/><br/>
              <input class="innputstyle" type="button"  name="emitirNF"      value=" Emitir Nota Fiscal " title="Clique para Emitir a Nota Fiscal" onclick="emitirNotaFiscal('<%out.write(String.format("%03d",venda.getIdVenda()));%>');"/><br/>
              <input class="innputstyle" type="button"  name="excluir"       value="   Excluir Venda   " title="Excluir Toda Venda:<%out.write(String.format("%03d",venda.getIdVenda()));%>" onclick="ExcluirVenda('<%out.write(String.format("%03d",venda.getIdVenda()));%>');"/><br/>
              <input type="button" name="voltar"  id="voltar" title="Clique para voltar à janela Anterior"                  value="        Voltar         " class="innputstyle" onclick="javascript: window.history.go(-1);"/>
                </div></td>
          </tr>

          <tr>
            <td align="center" colspan="2"><div align="CENTER">
                    <span id="desc_produto" class="formato_label" style="color: #FF0000"><%

                        if(descProduto!=null){
                            out.write(descProduto);
                            descProduto="";
                            }else{
                           out.write("Sabendo o Código do Produto digite, digite a Quantidade e Clique Inserir! Se não Clique Localizar Produto!");
                            }
            %></span>
            </div></td>

            <td>
                <%  if(habilitarFpg.length()>1){
               out.println("<SELECT name='fpg' id='fpg' size='1' "+habilitarFpg+">");
               } else {
                  out.println("<SELECT name='fpg' id='fpg' size='1'>");
               }

                out.println("<OPTION value='00'        >FORMA DE PAGAMENTO</OPTION>");
                out.println("<OPTION value='A VISTA'   >PAGAMENTO: A VISTA</OPTION>");
                out.println("<OPTION value='EM CHEQUE' >PAGAMENTO: EM CHEQUE</OPTION>");
                out.println("<OPTION value='EM CARTAO' >PAGAMENTO: EM CARTAO</OPTION>");
                out.println("</SELECT>");

     out.println("<SCRIPT language='JavaScript'>");
     out.println("document.getElementById('fpg').options["+ indiceFpg +"].selected='true';");
     out.println("</SCRIPT>");

%>
            <div align="right"><span class="formato_label">N Itens:</span></div></td>
            <td>&nbsp;<div align="right"><span class="formato_label"><% out.write(String.format("%03d",venda.getnItens())); %></span></div></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td><div align="right"><span class="formato_label">Total dos Itens:</span></div></td>
            <td><div align="right"><span class="formato_label">
            <% out.write(venda.recuperarValorMoedaFormatado(venda.gettItens())); %></span></div></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td><div align="right">
                        <span class="formato_label" style="color: #FF0000">Fidelidade Pontos:
                        <% out.write(String.format("%03d",venda.getApoioPontos())); %>
                        &nbsp;&nbsp;
                        = &nbsp; <% if(venda.getApoioPontos()>=10){
                        out.write(String.format("%02d",venda.fazerDesconto(venda.getApoioPontos()))+"%");
                            }else{
                            out.write("00");
                            }%>
                        &nbsp;&nbsp;
                        Desconto:</span></div></td>
            <td><div align="right"><span class="formato_label" style="color: #FF0000">
            <% out.write(venda.recuperarValorMoedaFormatado(venda.getDesconto())); %></span></div></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td><div align="right"><span class="formato_label">Total da Venda:</span></div></td>
            <td><div align="right"><span class="formato_label">
            <% out.write(venda.recuperarValorMoedaFormatado(venda.gettVenda())); %></span></div></td>
          </tr>

          <tr>
            <td colspan="4"><div align="center">
                <table width="579" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                        <table width="750" border="0" frame="hsides" rules="rows"
                               bordercolor="#ff0000">
                        <tr>
                          <td width="80"><div align="right" class="formato_label"><strong>ID</strong></div></td>
                          <td width="220"><div align="left" class="formato_label"><strong>Nome</strong></div></td>
                          <td width="80"><div align="right" class="formato_label"><strong>Quantidade</strong></div></td>
                          <td width="130"><div align="right" class="formato_label"><strong>Valor</strong></div></td>
                          <td width="80"><div align="right" class="formato_label"><strong>Total</strong></div></td>
                          <td width="100"><div align="left" class="formato_label"><strong>&nbsp;&nbsp;Manutenção</strong></div></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>

         <% if(venda.getnItens()>0){
         List listarIntens = venda.listarItens(venda.getIdVenda());
         Iterator listarIterator = listarIntens.iterator();
         lItemVenda listar;
         while(listarIterator.hasNext()){
         listar = (lItemVenda) listarIterator.next();
         
    %>



                        <tr>
                          <td><div align="right" class="formato_label"><%=String.format("%03d",listar.getIdProduto())%></div></td>
                          <td><div align="left" class="formato_label"><%=listar.getNome()%></div></td>
                          <td><div align="right" class="formato_label"><%=String.format("%03d",listar.getQuantidade())%></div></td>
                          <td><div align="right" class="formato_label"><%=venda.recuperarValorMoedaFormatado(listar.getValor_compra())%></div></td>
                          <td><div align="right" class="formato_label"><%=venda.recuperarValorMoedaFormatado(listar.getTotal_itens())%></div></td>
                          <td><div align="left" class="formato_label">
                          <img src="IMG/erase.png"  alt="excluir" title="Excluir: <%=listar.getNome()%>" onclick="excluirItemVenda(<%=listar.getIdProduto()%>,'<%=listar.getNome()%>');">
                              </div></td>
                        </tr>


                        <%}
         }%>


                        </table></td>
                  </tr>
                </table>
            </div></td>
          </tr>
        </table>
        <p>&nbsp;</p>
      </form>
        </fieldset>
    </div></td>
  </tr>
  <tr>
    <td colspan="4" bgcolor="#005CFB"><div align="center" class="dr">
      <p>@FARMA - © Copyright 2015      <br />
      </p>
      </div></td>
    <td>&nbsp;</td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>

   </body>
</html>

<%
       }
     }else{
%>
<jsp:forward page="logar.jsp" />
<%
}
%>