<%-- 
    Document   : principal
    Created on : 05/06/2015, 19:32:46
    Author     : Erick Medeiros
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página Restrita</title>
        <link href="estiloscss/estilos.css" rel="stylesheet" type="text/css">
    </head>
   <body>
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
    <td height="25" colspan="5" bgcolor="#01A7D9"><div align="center"><a href="link_cadastros.jsp">JANELA PRINCIPAL</a>&nbsp; &nbsp;
            <a href="index.jsp">HOME</a>&nbsp; &nbsp; <a href="logout.jsp">Logout</a></div>
    <td>
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
    <td colspan="5" align="left" valign="top"><table width="552" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="27" align="center"><a href="RelListaProdutos">Lista de Produtos</a></td>
        </tr>
        <tr>
          <td height="21" align="center"><a href="emissao_NotaFiscal.jsp">Emissão de Nota Fiscal</a></td>
        </tr>
      </table>
    <p align="center" class="style4">&nbsp;</p></td>
  </tr>
  <tr>
    <td colspan="4" bgcolor="#005CFB"><div align="center" class="dr">
      <p>@FARMA - © Copyright 2015   -> Usuário Logado: <%
String s = request.getParameter("email_logar");
out.write(s);
                      %> <-<br />
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