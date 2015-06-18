<script type="text/javascript" src="js/validaCadastros.js"></script>
<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" import="com.afarma.controle.*"%>

<%
     Boolean logado = (Boolean) session.getAttribute("Logado");
     Boolean administrador =  (Boolean)session.getAttribute("Administrador");
     if(logado != null && administrador != null){
        if(logado && administrador ){
            %>
			<jsp:forward page="link_cadastros.jsp" />
			<%
        } else {
             %>
			<jsp:forward page="link_cadastros.jsp" />
			<%
        }
     }else{
         %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::Acesso à Área Restrita::</title>
        <link href="estiloscss/estilos.css" rel="stylesheet" type="text/css">
    </head>
   <body>

    <%
    String acao = "0";
    acao = request.getParameter("acao");
    if(acao == null){
        acao = new  String();
    }
    boolean result= false;
        if(acao.equals("1")){
            Funcionario control = new Funcionario();
        String s = "<h2>Usuário não encontrado: "+request.getParameter("email_logar")+"</h2>";
        out.write(s);
            result = control.validaUsuario(request.getParameter("email_logar"),request.getParameter("senha_logar"));
            if(result == true ){
                session.setAttribute("Logado", true);
                session.setAttribute("usuario", control.getEmail());
                if (control.getPerfilAdm()){
                    session.setAttribute("Administrador", true);
                    } else {
                    session.setAttribute("Administrador", false);
                    }
                %>
				<jsp:forward page="link_cadastros.jsp" />
				<%
            }else{
                session.setAttribute("Administrador", false);
                }
        }
    }
    %>





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
    <td height="25" colspan="5" bgcolor="#01A7D9"><div align="center"><a href="index.jsp">HOME</a> <a href="#"><span class="div_menu">| </span></a><a href="link_cadastros.jsp">CADASTRE-SE</a></div></td>
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
    <td colspan="5" valign="top"><form name="formLogin" method="post" action="logar.jsp?acao=1">
      <table width="415" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td valign="top"><fieldset>
            <legend class="formato_label">Acesso Restrito.<br />
            <br />
            </legend>
            <table width="368" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="118"><div align="right"><span class="formato_label">e-mail:</span></div></td>
                <td width="250" align="center"><label>
                  <input name="email_logar" type="text" id="email" size="30" />
                    </label>                  </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><label></label>
                    </td>
              </tr>
              <tr>
                <td align="center"><div align="right"><span class="formato_label">Senha:</span></div></td>
                <td align="center"><label>
                  <input name="senha_logar" type="password" id="senhalogar" size="30"
                         onkeyup="removeCaractresSpeciais(this);"/>
                  </label>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><label></label>
                    </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><label>
                    <div align="center"></div>
                  <div align="right"></div>
                  </label></td>
              </tr>
              <tr>

                  
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><div align="center">
                    <input type="submit" name="submit" id="submit" value=" Logar " class="inputstyle"/>
                    <input type="reset" name="reset" id="reset" value="Limpar" class="inputstyle"/>
                </div></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><div align="right">
                    <label></label>
                </div></td>
              </tr>
            </table>
            </fieldset>
            <p align="center" class="formato_label">&nbsp;</p></td>
        </tr>
      </table>
        </form>

    </td>
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
