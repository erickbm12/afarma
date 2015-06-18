<%-- 
    Document   : entrada_produtos
    Created on : 05/06/2015, 19:32:46
    Author     : Erick Medeiros
--%>


<script type="text/javascript" src="js/validaCadastros.js"></script>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*,com.afarma.listas.*"%>
<jsp:useBean id="fornecedor" scope="page" class="com.afarma.controle.Fornecedor"/>
<jsp:useBean id="produto" scope="page" class="com.afarma.controle.Produto"/>
<jsp:useBean id="funcionario" scope="page" class="com.afarma.controle.Funcionario"/>
<jsp:useBean id="itenEntrada" scope="page" class="com.afarma.controle.ItemEntrada"/>
<jsp:useBean id="entrada" scope="session" class="com.afarma.controle.Entrada"/>

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

////////////////////////////// verifica se e uma nova entrada ou a instanciar de uma Existente \\\\\\\\\\\\\\\\\\\\\\\\
     if(((entrada.getStatusEntrada()==null)&&((entrada.getStatusEntrada()!="nova")||(entrada.getStatusEntrada()!="localizar")))){
     %>
     <jsp:forward page="busca_fornecedor_entrada.jsp" />
     <%  
  }
////////////////////////////// fim verifica se e uma nova entrada ou a instanciar de uma Existente \\\\\\\\\\\\\\\\\\\\\\\\

        
     String acao = "";
     acao        = request.getParameter("acao");

     /* retorno da Busca de Produto */
     String idProduto    = "";
     String descProduto  = "";     

     idProduto    = request.getParameter("id_produto");
     descProduto  = request.getParameter("nome_prodLoc");

     if(entrada.getApoioIdFor()!=null)
     fornecedor.instanciarFornecedor(entrada.getApoioIdFor());
     funcionario.instanciarFuncionario((String)session.getAttribute("usuario"), 2);
     produto.instanciarProduto(idProduto);

    if(acao == null){
        acao = new  String();
    }
     
////////////////////////////// incluir um Produto \\\\\\\\\\\\\\\\\\\\\\\\
     if(acao.equals("1")){    

     
     if(fornecedor.getNome()==null){
     out.println("<SCRIPT language='JavaScript'>");
     out.println("alert('Fornecedor Não Encontrado! Operação cancelada!');");
     out.println("</SCRIPT>");
     %>
     <jsp:forward page="busca_fornecedor_entrada.jsp" />
     <%  
         }else
     if(produto.getNome()==null){
     out.println("<SCRIPT language='JavaScript'>");
     out.println("alert('Produto Não Encontrado! Operação cancelada!');");
     out.println("</SCRIPT>");     
     }else{


         /*Retorno que inica com tres-> retornos de produtos*/
////////////////////////////// se a quantidade de Itens = 0 Inseri uma Nova Entrada \\\\\\\\\\\\\\\\\\\\\\\\
         if(entrada.getnItens()==0){         
         entrada.setDataApoio(request.getParameter("data_entrada"));
         entrada.setFornecedor(fornecedor);
         entrada.setFuncionario(funcionario);
         entrada.inserirEntrada();
         }
////////////////////////////// fim se a quantidade de Itens = 0 Inseri uma Nova Entrada \\\\\\\\\\\\\\\\\\\\\\\\
////////////////////////////// inseri os itens na entrada \\\\\\\\\\\\\\\\\\\\\\\\
         int quantidade   = 0;
         double valor     = 0;
         double valorVenda= 0;
         quantidade   = Integer.parseInt(request.getParameter("quantidade_produto"));
         valor        = Double.parseDouble(request.getParameter("valor_produto"));
         valorVenda   = Double.parseDouble(request.getParameter("valor_produtoVenda"));


         entrada.adicionaItem(produto, quantidade , valor, valorVenda);

         if(entrada.getRetorno()==35){
             out.println("<SCRIPT language='JavaScript'>");
             out.println("alert('Produto já Existe na Entrada! Não foi possível Inserir!');");
             out.println("</SCRIPT>");
             }
         
////////////////////////////// fim inseri os itens na entrada \\\\\\\\\\\\\\\\\\\\\\\\
         }

       
       }
////////////////////////////// fim incluir um Produto \\\\\\\\\\\\\\\\\\\\\\\\
////////////////////////////// exclui um item de uma entrada \\\\\\\\\\\\\\\\\\\\\\\\
     if(acao.equals("34")){         
     //produto.instanciarProduto(idProduto);
     itenEntrada.instanciarItenEntrada(entrada.getIdEntrada(), produto);         
     entrada.removeItem(itenEntrada);
         }
////////////////////////////// fim exclui um item de uma entrada \\\\\\\\\\\\\\\\\\\\\\\\
////////////////////////////// instancia uma entrada \\\\\\\\\\\\\\\\\\\\\\\\
     if(acao.equals("3")){

         String idEntradaLoc = "";
         idEntradaLoc = request.getParameter("id_entrada");
         if(idEntradaLoc!=null)
         entrada.instanciarEntrada(Integer.parseInt(idEntradaLoc));
         fornecedor.instanciarFornecedor(Integer.toString(entrada.getFornecedor().getIdFornecedor()));
         
         }
////////////////////////////// fim instancia uma entrada \\\\\\\\\\\\\\\\\\\\\\\\
     %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::ENTRADA DE PRODUTOS::</title>


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
 <body onload="setarEdit('id_produto')">
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
    <legend class="formato_label"> Entrada de Produtos: </legend>
    <legend class="formato_label"></legend>
    <form name="formEntradaProdutos" method="post" onSubmit="return validaInsercaoEntrada(this);" action="entrada_produtos.jsp?acao=1">

        <table width="579" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="110">&nbsp;</td>
            <td width="84" class="formato_label">&nbsp;</td>
            <td width="241" align="center"><a href="busca_entradas.jsp"><font size="4" color="#000000">BUSCA ENTRADA</font></a><br/>
                            <a href="busca_fornecedor_entrada.jsp"><font size="4" color="#000000">NOVA ENTRADA</font></a></td>
            <td width="144">&nbsp;</td>
          </tr>

          <tr>
            <td><div align="right"><span class="formato_label">ID Entrada:</span></div>

            </td>

            <td align="center" class="formato_label"><div align="left">
                  <input name="id_entrada" type="text" id="id_entrada" size="10"
                         style="text-align:right"
                         maxlength="10" readonly="true"
                         value=<%out.write(String.format("%03d",entrada.getIdEntrada()));%>>
                </div></td>
                <td align="center" ><div align="right">
                        <span class="formato_label">Data:</span></div></td>
                        <td align="center" class="formato_label"><div align="left">
                  <input name="data_entrada" type="text" id="data_entrada" size="10"
                         maxlength="10"  onkeypress="mascara(this, dataMascara);"
                         onblur="doDate(this.value, 5);"
                         value=<%=entrada.getDataApoio()%>  >
                </div></td>
          </tr>

          <tr>
            <td><div align="right"><span class="formato_label">ID Fornecedor:</span></div></td>
            <td align="center" class="formato_label"><div align="left">
            <input name="id_fornecedor" type="text" id="id_fornecedor" size="10"
            style="text-align:right"
            maxlength="10" readonly="true"
            value=<%out.write(String.format("%03d",fornecedor.getIdFornecedor()));%>>
            </div></td>
            <td align="center" colspan="3"><div align="left">
            <span class="formato_label"><%=fornecedor.getNome()%></span>
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

            <td>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="25%"><div align="right"><span class="formato_label">Quantidade:</span></div></td>
            <td width="25%" align="center" class="formato_label"><div align="left"><input name="quantidade_produto" type="text" id="quantidade_produto" size="7"
            style="text-align:right"
            maxlength="10" onKeyPress="mascara(this,soNumeros);"
            value="0"/></div></td>
            <td width="25%"><div align="right"><span class="formato_label">V.Compra:</span></div></td>
            <td width="25%" align="center" class="formato_label"><div align="left"><input name="valor_produto" type="text" id="valor_produto" size="7"
            style="text-align:right"
            maxlength="10" onkeyup="formataMoedaIngles(this);"
            value="0"/></div></td>

          </tr>
          <tr>
            <td width="25%">&nbsp;</td>
            <td width="25%">&nbsp;</td>
            <td width="25%"><div align="right"><span class="formato_label">V.Venda:</span></div></td>
            <td width="25%" align="center" class="formato_label"><div align="left">
                    <input name="valor_produtoVenda" type="text" id="valor_produtoVenda" size="7"
            style="text-align:right"
            maxlength="10" onkeyup="formataMoedaIngles(this);"
            value="0"/></div></td>

          </tr>


                </table>
            </td>
            <td><div align="center">
              <input class="innputstyle" type="submit"  name="Submit"  value=      "        Inserir        " title="Clique para Inserir o Produto na Entrada" onclick="enviar(this.form)"/><br/>
              <input class="innputstyle" type="button"  name="loc_produto"   value=" Localizar Produto " title="Clique para Localizar um Produto e Inserir na Entrada" onclick="buscaProdutoEntrada();"/><br/>
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
                out.write("Sabendo o Código do Produto digite, digite a Quantidade o Valor de Compra e Venda depois Clique Inserir! Se não Clique Localizar Produto!");
                }
            %></span>
            </div></td>
            
            <td><div align="right"><span class="formato_label">N Itens:</span></div></td>
            <td><div align="right"><span class="formato_label"><% out.write(String.format("%03d",entrada.getnItens())); %></span></div></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td><div align="right"><span class="formato_label">Total:</span></div></td>
            <td><div align="right"><span class="formato_label">
            <% out.write(entrada.recuperarValorMoedaFormatado(entrada.gettEntrada())); %></span></div></td>
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
                          <td width="130"><div align="right" class="formato_label"><strong>Valor Compra </strong></div></td>
                          <td width="80"><div align="right" class="formato_label"><strong>Total</strong></div></td>
                          <td width="100"><div align="left" class="formato_label"><strong>&nbsp;&nbsp;Manutenção</strong></div></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>

         <% if(entrada.getnItens()>0){
         List listarIntens = entrada.listarItens(entrada.getIdEntrada());
         Iterator listarIterator = listarIntens.iterator();
         lItemEntrada listar;
         while(listarIterator.hasNext()){
         listar = (lItemEntrada) listarIterator.next();
         
    %>



                        <tr>
                          <td><div align="right" class="formato_label"><%=String.format("%03d",listar.getIdProduto())%></div></td>
                          <td><div align="left" class="formato_label"><%=listar.getNome()%></div></td>
                          <td><div align="right" class="formato_label"><%=String.format("%03d",listar.getQuantidade())%></div></td>
                          <td><div align="right" class="formato_label"><%=entrada.recuperarValorMoedaFormatado(listar.getValor_compra())%></div></td>
                          <td><div align="right" class="formato_label"><%=entrada.recuperarValorMoedaFormatado(listar.getTotal_itens())%></div></td>
                          <td><div align="left" class="formato_label">
                          <img src="IMG/erase.png"  alt="excluir" title="Excluir: <%=listar.getNome()%>" onclick="excluirItemEntrada(<%=listar.getIdProduto()%>,'<%=listar.getNome()%>');">
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