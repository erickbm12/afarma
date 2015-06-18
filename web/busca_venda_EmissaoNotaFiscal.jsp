<%-- 
    Document   : busca_entradas
    Created on : 03/06/2015, 19:32:45
    Author     : Erick Medeiros
--%>


<script type="text/javascript" src="js/validaBusca.js"></script>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*,com.afarma.listas.*"%>
<jsp:useBean id="venda" scope="page" class="com.afarma.controle.Venda"/>
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



     String acao  = "0";
     String cpf    ="";
     String filtro1="";
     String filtro2="";

     acao   = request.getParameter("acao");
     cpf     = request.getParameter("editConteudo");
     filtro1 = request.getParameter("editDeLoc");
     filtro2 = request.getParameter("editParaLoc");




    if(acao == null){
        acao = new  String();
    }


%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::BUSCA DE VENDAS PARA EMITIR NOTA FISCAL::</title>


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
 <body onload="setarTipoLocEmissaoNotaFiscal()">
<table width="775" border="0" align="center" cellpadding="0" cellspacing="0" >
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
    <td colspan="5" valign="top"><div align="center"><fieldset>
    <legend class="formato_label"> Busca de Vendas Para Emitir Nota Fiscal: </legend>
    <legend class="formato_label"></legend>
      <form id="form1" name="formBuscaVenda" method="post" action="busca_venda_EmissaoNotaFiscal.jsp?acao=1">

        <table width="579" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="150">&nbsp;</td>
            <td width="84" class="formato_label">&nbsp;</td>
            <td width="241">&nbsp;</td>
            <td width="144">&nbsp;</td>
          </tr>
          <tr>

              <%--  <td>&nbsp;</td>
            <td>&nbsp;</td> --%>

              <td class="formato_label"> &nbsp; </td>

              <td align="center" class="formato_label" colspan="2" style="color: #FF0000">  &nbsp; </td>
            
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td class="formato_label">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>

              <td colspan="4"><label>
                    <label class="formato_label"  id="descRadio">Digite o CPF do Cliente e Informe o Período:</label><br>
                    <input class="inputstyle" type="text" size="40%"
                           name="editConteudo" id="editConteudo" maxlength="11"
                           onKeyPress="mascara(this,soNumeros)">

                    <input class="inputstyle" type="text" size="10"
                           name="editDeLoc" id="editDeLoc" maxlength="10"
                           onkeypress="mascara(this, dataMascara);"
                           onblur="doDate(this.value, 5);"> &nbsp;

                    <input class="inputstyle" type="text" size="10"
                           name="editParaLoc" id="editParaLoc" maxlength="10"
                           onkeypress="mascara(this, dataMascara);"
                           onblur="doDate(this.value, 5);">
              <input class="innputstyle" type="button" name="Submit"  value=" Busca  " onclick="enviarLocComDatasNF(this.form)"/>
              <input class="innputstyle" type="reset"  name="reset" id="reset" value="Cancelar"/>
              <input class="innputstyle" type="button"  name="voltar"  id="voltar" title="Clique para voltar à janela Anterior"  value="Voltar" onclick="javascript: window.history.go(-1);"/>
                </label>

            </td>

          </tr>


          <tr>
            <td>&nbsp;</td>
            <td class="formato_label">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td colspan="4"><div align="center">
                <table width="579" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td><table width="930" border="0" frame="hsides" rules="rows"
                               bordercolor="#ff0000">
                        <tr>
                          <td width="80"><div align="right" class="formato_label"><strong>ID</strong></div></td>
                          <td width="200"><div align="left" class="formato_label"><strong>Nome</strong></div></td>
                          <td width="80"><div align="right" class="formato_label"><strong>N. Itens</strong></div></td>
                          <td width="130"><div align="right" class="formato_label"><strong>Total Itens</strong></div></td>
                          <td width="130"><div align="right" class="formato_label"><strong>Desconto</strong></div></td>
                          <td width="130"><div align="right" class="formato_label"><strong>Total Venda</strong></div></td>
                          <td width="80"><div align="right" class="formato_label"><strong>Data</strong></div></td>
                          <td width="100"><div align="left" class="formato_label"><strong>Manutenção </strong></div></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>


<%

     if(acao.equals("1")){

         List listarVend = venda.listar(4, filtro1, filtro2, cpf);
         Iterator listarIterator = listarVend.iterator();
         lVendas listar;

         while(listarIterator.hasNext()){
         listar = (lVendas) listarIterator.next();

%>
                        <tr>
                            <td><div align="right" class="formato_label"><%=String.format("%03d",listar.getIdVenda())%></div></td>
                            <td align="left" class="formato_label"><%=listar.getNome()%> </td>
                            <td align="right" class="formato_label"><%=String.format("%03d",listar.getnItens())%></td>
                            <td align="right" class="formato_label"><% out.write(venda.recuperarValorMoedaFormatado(listar.gettItens())); %></td>
                            <td align="right" class="formato_label"><% out.write(venda.recuperarValorMoedaFormatado(listar.getDesconto())); %></td>
                            <td align="right" class="formato_label"><% out.write(venda.recuperarValorMoedaFormatado(listar.gettVendas())); %></td>
                            <td align="right" class="formato_label"><%= listar.getDataVenda() %></td>
                            <td align="center" class="formato_label"><a
                           title="Emitir Nota Fiscal:<%=listar.getIdVenda()%>  <%=listar.getNome()%>"
                           href="emissao_NotaFiscal.jsp?id_notaFiscal=<%=listar.getIdVenda()%>">
                           <img src="IMG/print.png" alt="Emitir Nota" style="border: 0"/></a>
                            </td>
                        </tr>

                        <%

                        }
                    }

                        %>
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