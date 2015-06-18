<%-- 
    Document   : busca_produto_entrada
    Created on : 03/06/2015, 19:32:45
    Author     : Erick Medeiros
--%>


<script type="text/javascript" src="js/validaBusca.js"></script>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*,java.text.DecimalFormat, com.afarma.listas.*"%>
<jsp:useBean id="produto" scope="page" class="com.afarma.controle.Produto"/>
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
     String tipo  = "";
     String filtro="";
     String idProduto="";
     acao   = request.getParameter("acao");
     tipo   = request.getParameter("tipo");
     filtro = request.getParameter("editConteudo");
     idProduto = request.getParameter("id_produto");
     DecimalFormat formatarDecimal = new DecimalFormat("###0.00");

    if(acao == null){
        acao = new  String();
    }

%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::BUSCA DE PRODUTO VENDA::</title>

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
 <body onload="setarTipo()">
<table width="776" border="0" align="center" cellpadding="0" cellspacing="0" >
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
    <td colspan="5" valign="top"><div align="center"><fieldset>
    <legend class="formato_label"> Busca Produto para Vender: </legend>
    <legend class="formato_label"></legend>
      <form id="form1" name="formBusca" method="post" action="busca_produto_venda.jsp?acao=1">

        <table width="579" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="110">&nbsp;</td>
            <td width="84" class="formato_label">&nbsp;</td>
            <td width="241">&nbsp;</td>
            <td width="144">&nbsp;</td>
          </tr>
          <tr>

              <%--  <td>&nbsp;</td>
            <td>&nbsp;</td> --%>

            <td class="formato_label">

                <input class="inputstyle" type="radio" name="tipo"  value="1" onclick="descLabelProduto(this.form)" >
              ID
                <br>
                <input class="inputstyle" type="radio" name="tipo"  value="2" onclick="descLabelProduto(this.form)" checked="true">
              Nome
                <br>
                <input class="inputstyle" type="radio" name="tipo"  value="3" onclick="descLabelProduto(this.form)">
              Descrição
                <br>
                <input class="inputstyle" type="radio" name="tipo"  value="4" onclick="descLabelProduto(this.form)">
              Laboratório
            </td>

            <td align="center" class="formato_label"> &nbsp; </td>
            <td align="center" >&nbsp; </td>
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
                    <label class="formato_label"  id="descRadio">Digite qualquer parte do Nome:</label><br>
                    <input class="inputstyle" type="text" size="40%"
                           name="editConteudo" id="editConteudo" maxlength="50"
                           onkeyup="removeCaractresSpeciais(this);"
                           onKeyPress="mascara(this,soNumerosID);">
              <input class="innputstyle" type="button" name="Submit"  value=" Busca  " onclick="enviar(this.form)"/>
              <input class="innputstyle" type="reset"  name="reset" id="reset" value="Cancelar"/>
              <input type="button" name="voltar"  id="voltar" title="Clique para voltar à janela Anterior"  value="    Voltar  " class="innputstyle" onclick="javascript: window.history.go(-1);"/>
                </label>

            </td>

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
                    <td><table width="750" border="0" frame="hsides" rules="rows"
                               bordercolor="#ff0000">
                        <tr>
                          <td width="101"><div align="right" class="formato_label"><strong>ID</strong></div></td>
                          <td width="252"><div align="left" class="formato_label"><strong>Nome</strong></div></td>
                          <td width="252"><div align="left" class="formato_label"><strong>Descrição</strong></div></td>
                          <td width="204"><div align="left" class="formato_label"><strong>Laboratório</strong></div></td>
                          <td width="204"><div align="rigth" class="formato_label"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Estoque</strong></div></td>
                          <td width="204"><div align="rigth" class="formato_label"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Valor</strong></div></td>
                          <td width="204"><div align="rigth" class="formato_label"><strong>Inserir</strong></div></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>


<%

     if((acao.equals("1")) && (tipo != null) && (filtro != null)){

         List listarProd = produto.listarProduto(tipo, filtro);
         Iterator listarIterator = listarProd.iterator();
         lProduto listar;

         while(listarIterator.hasNext()){
         listar = (lProduto) listarIterator.next();

%>
                        <tr>
                            <td><div align="right" class="formato_label"><%=String.format("%03d",listar.getIdProduto())%></div></td>
                            <td align="left" class="formato_label"><%=listar.getNome()%> </td>
                            <td align="left" class="formato_label"><%=listar.getDescricao()%> </td>
                            <td align="left" class="formato_label"><%=listar.getLab()%></td>
                            <td align="right" class="formato_label"><%=String.format("%03d",listar.getQuantidade())%></td>
                            <td align="right" class="formato_label"><%out.write(formatarDecimal.format(listar.getValor_venda()));%>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td align="left" class="formato_label"><a  
                           title="Adicionar na Entrada:<%=listar.getNome()%>"
                           href="venda_produtos.jsp?id_produto=<%=listar.getIdProduto()%>&nome_prodLoc=<%=listar.getNome()%>&valorVenda_prodLoc=<%=listar.getValor_venda()%>&estoque_prodLoc=<%=listar.getQuantidade()%>">
                           <img src="IMG/adicionar.png" alt="Adicionar a Entrada" style="border: 0"/></a>

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