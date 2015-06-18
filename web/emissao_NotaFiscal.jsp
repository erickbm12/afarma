<%-- 
    Document   : emissao_NotaFiscal
    Created on : 05/06/2015, 19:32:46
    Author     : Erick Medeiros
--%>
<script type="text/javascript" src="js/validaCadastros.js"></script>
<%@page contentType="text/html" pageEncoding="UTF-8"  import="java.util.*"%>
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
            

            String acao = "0";
            String idNotaFiscal = null;
            String retorno      = "0";
            acao = request.getParameter("acao");
    if(acao == null){
        acao = new  String();
    }
         ////// acao 01 emitir Nota Fiscal \\\\\\\

            idNotaFiscal = request.getParameter("id_notaFiscal");

            if(((idNotaFiscal== null)||(idNotaFiscal==""))){
               idNotaFiscal = "0" ;
                }

            if(acao.equals("1")){                                

            if(Integer.parseInt(idNotaFiscal)>0){

                // verifica se a venda foi fechada, se sim vai para o else, se nao abre a venda novamente
                if(venda.verificarSeAVendaEstaAbertaDireto(idNotaFiscal)){

                    retorno     ="2";
                    out.println("alert('Finalizar a Venda antes de Emitir a Nota Fiscal!');");
             %>
                <jsp:forward page="venda_produtos.jsp">
                <jsp:param name="acao"    value="3"/>
                <jsp:param name="id_venda"    value="<%= idNotaFiscal %>"/>
                </jsp:forward>
             <%   
                    
                    }else{


// se a venda foi fechada direitinho emite a nota fiscal
             %>
                <jsp:forward page="emissaoNotaFiscal">
                <jsp:param name="idNotaFiscal"    value="<%= idNotaFiscal %>"/>
                </jsp:forward>
             <%                

           }
             }else{
                idNotaFiscal="0";
                retorno     ="1";
                }

               }
            /////// fim - acao emitir nota fiscal \\\\\\\

            out.println("<SCRIPT language='JavaScript'>");
                   switch(Integer.parseInt(retorno)){
                        case 1:
                            out.println("alert('Favor Informa o Número da Nota Fiscal!');");
                            break;
                        case 2:
                            out.println("alert('Finalizar a Venda antes de Emitir a Nota Fiscal!');");
                            break;
                    }
               out.println("</SCRIPT>");

%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::Emissão de Nota Fiscal::</title>
        <link href="estiloscss/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body onload="setarEdit('id_notaFiscal')">
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
    <td height="25" colspan="5" bgcolor="#01A7D9"><div align="center"><a href="link_cadastros.jsp">JANELA PRINCIPAL</a>&nbsp; &nbsp;<a href="index.jsp">HOME</a> <a href="#"><span class="div_menu">| </span></a><a href="cadastrar_clientes.jsp">CADASTRAR CLIENTES </a><a href="#"><span class="div_menu">|</span></a> <a href="cadastrar_funcionarios.jsp">CADASTRAR FUNCIONÁRIOS</a> <a href="#"><span class="div_menu">|</span></a> <a href="cadastrar_fornecedores.jsp">CADASTRAR FORNECEDORES</a> </div></td>
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
    <td colspan="5" valign="top"><form name="formManutProd" method="post"
  onsubmit="return validarFieldIdNotaFiscal(this)" action="emissao_NotaFiscal.jsp?acao=1">
      <table width="524" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td valign="top"><fieldset>
            <legend class="formato_label">Emissão de Nota Fiscal:<br />
            <br />
            </legend>
            <table width="500" border="0" cellspacing="0" cellpadding="0">

              <tr>
                <td width="150"><div align="right"><span class="formato_label">ID da Venda:</span></div></td>
                <td width="15" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="339" align="center"><div align="left">
                <input name="id_notaFiscal" id="id_notaFiscal" type="text" id="id" size="10"
                       style="text-align:right"
                        value="<%
                        if(Integer.parseInt(idNotaFiscal)>0){
                           out.write(String.format("%03d",Integer.parseInt(idNotaFiscal)));
                                   }else{
                out.write("");
                };
                            %>"

                 onkeyup="removeCaractresSpeciais(this);"
                 onkeypress="mascara(this,soNumeros)"                           
                 onblur="validaVazio(this,document.getElementById('idNota_help'));"

                            />
                <span id="idNota_help" class="help"></span>
                    </div>
                </td>
              </tr>


              <tr>
                <td><div align="right"></div></td>
                <td><div align="center"></div></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><div align="right"></div></td>
                <td>
                  <div align="left"></div></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><div align="right"></div></td>
                <td><div align="center"></div></td>
                <td>
                  <input type="submit" name="submit" id="submit" value="   Emitir   " class="inputstyle"/>
                  <input type="button" name="reset" id="reset"   value="   Cancelar " class="inputstyle" onclick="limparCamposEmissaoNotaFiscal(form);"/>
                  <input type="button" name="busca" id="busca"   value="    Busca   " class="inputstyle" onclick="buscaNotaFiscal();"/>
                  <input type="button" name="voltar"  id="voltar" title="Clique para voltar à janela Anterior"  value="    Voltar  " class="inputstyle" onclick="javascript: window.history.go(-1);"/>

                </td>
              </tr>
              <tr>
                <td><div align="right"></div></td>
                <td>
                  <div align="left"></div></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><div align="center"></div></td>
                <td>&nbsp;</td>
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


<%
       }
     }else{
%>
<jsp:forward page="logar.jsp" />
<%
}
%>