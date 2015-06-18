<%-- 
    Document   : busca
    Created on : 03/06/2015, 19:32:45
    Author     : Erick Medeiros
--%>


<script type="text/javascript" src="js/validaBusca.js"></script>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
     Boolean logado = (Boolean) session.getAttribute("Logado");
     Boolean administrador = (Boolean) session.getAttribute("Administrador");

     if(logado != null && administrador != null){
        if((!logado) || (!administrador)){
%>
        <jsp:forward page="logar.jsp" />
<%
        }else{

     String acao = "";
     String tipo = "";
     String valor="";
     acao   = request.getParameter("acao");
     tipo   = request.getParameter("tipo");
     valor  = request.getParameter("editConteudo");

    if(acao == null){
        acao = new  String();
    }

     %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::BUSCA DE CLIENTES::</title>


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
    <td height="30" colspan="5" bgcolor="#01A7D9"><div align="center"><a href="link_cadastros.jsp">Janela Principal</a>&nbsp; &nbsp;<a href="index.jsp">HOME</a>&nbsp; &nbsp; <a href="logout.jsp">Logout</a></div></td>
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
    <legend class="formato_label"> Busca: </legend>
    <legend class="formato_label"></legend>
      <form id="form1" name="formBusca" method="post" action="busca.jsp?acao=1">

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

                <input class="inputstyle" type="radio" name="tipo"  value="1" onclick="limparEdit(this.form)" checked="true">
              ID
                <br>
                <input class="inputstyle" type="radio" name="tipo"  value="2" onclick="limparEdit(this.form)">
              Nome
            </td>

<td align="center" class="formato_label"> OU </td>
            <td align="center" ><a href="cadastrar_funcionarios.jsp"><font size="5" color="#000000">NOVO FUNCIONÁRIO</font></a></td>
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
                    <label class="formato_label"  id="descRadio">Digite o ID:</label><br>
                    <input class="inputstyle" type="text" size="40%"
                           name="editConteudo" maxlength="50"
                           onkeyup="removeCaractresSpeciais(this);"
                           onKeyPress="mascara(this,soNumerosID);">
              <input class="innputstyle" type="button" name="Submit"  value=" Busca  " onclick="enviar(this.form)"/>
              <input class="innputstyle" type="reset"  name="reset" id="reset" value="Cancelar"/>
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
                    <td><table width="579" border="0" frame="hsides" rules="rows"
                               bordercolor="#ff0000">
                        <tr>
                          <td width="101"><div align="center" class="formato_label"><strong>ID</strong></div></td>
                          <td width="252"><div align="center" class="formato_label"><strong>Nome</strong></div></td>
                          <td width="204"><div align="center" class="formato_label"><strong>E-mail</strong></div></td>
                          <td width="204"><div align="center" class="formato_label"><strong>Clique para </strong></div></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td><div align="center" class="formato_label">001</div></td>
                          <td class="formato_label">Manoel ferreira Gomes da Silva </td>
                          <td class="formato_label">manoel@hotmail.com <% out.println(valor);%></td>
                          <td class="formato_label"><% out.println(valor); %></td>
                        </tr>
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