<%-- 
    Document   : cadastrar_fornecedores
    Created on : 03/06/2015, 19:32:45
    Author     : Erick Medeiros
--%>
<script type="text/javascript" src="js/validaCadastros.js"></script>
<%@page contentType="text/html" pageEncoding="UTF-8"  import="java.util.*, com.afarma.controle.*"%>
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



            Fornecedor control = new Fornecedor();
            String acao = "0";
            acao = request.getParameter("acao");
    if(acao == null){
        acao = new  String();
    }
         ////// acao 01 para atualizar um registro ou inserir \\\\\\\

            if(acao.equals("1")){

                String idForn = "0";
                idForn = request.getParameter("id_forCadastro");

                if(idForn != ""){

                   control.setIdFornecedor(Integer.parseInt(request.getParameter("id_forCadastro")));
                   control.setNome(request.getParameter("nome_fantasia"));
                   control.setRazaoSocial(request.getParameter("razao_social"));
                   control.setCNPJ(request.getParameter("cnpj"));
                   control.setContato(request.getParameter("nome_contato"));
                   control.setTelefone(request.getParameter("telefone_forn"));
                   control.setEmail(request.getParameter("email_forn"));

                   control.atualizarFornecedor();
                    }


                if(idForn == ""){

                   control.setNome(request.getParameter("nome_fantasia"));
                   control.setRazaoSocial(request.getParameter("razao_social"));
                   control.setCNPJ(request.getParameter("cnpj"));
                   control.setContato(request.getParameter("nome_contato"));
                   control.setTelefone(request.getParameter("telefone_forn"));
                   control.setEmail(request.getParameter("email_forn"));

                   control.inserir();
                    }
            out.println("<SCRIPT language='JavaScript'>");
                   switch(control.getRetorno()){
                        case 1:
                            out.println("alert('Registro Incluído com Sucesso!');");
                            break;
                        case 2:
                            out.println("alert('Não foi possível Inserir: e-mail já Cadastrado!');");
                            break;
                        case 3:
                            out.println("alert('Alteração Realizada com Sucesso!');");
                            break;
                    }
               out.println("</SCRIPT>");

               }
            /////// fim - acao para atualizar um registro \\\\\\\

            ////////////////////////////// excluir \\\\\\\\\\\\\\\\\\\\\\\\
                 if(acao.equals("2")){
                 control.excluirFornecedor(request.getParameter("id_fornecedor"));
                  }
            ////////////////////////////// fim excluir \\\\\\\\\\\\\\\\\\\\\\\\
            ////////////////////////////// instanciar \\\\\\\\\\\\\\\\\\\\\\\\
                if(acao.equals("3")){
                   control.instanciarFornecedor(request.getParameter("id_fornecedor"));
                }
            ////////////////////////////// fim instanciar \\\\\\\\\\\\\\\\\\\\\\\\



%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::Cadastrar Fornecedores::</title>
       <link href="estiloscss/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body onload="setarEdit('razao_social')">
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
    <td height="25" colspan="5" bgcolor="#01A7D9"><div align="center"><a href="link_cadastros.jsp">JANELA PRINCIPAL</a>&nbsp; &nbsp;<a href="index.jsp">HOME</a> <a href="#"><span class="div_menu">|</span></a><a href="cadastrar_clientes.jsp"> CADASTRAR CLIENTES </a><a href="#"><span class="div_menu">|</span></a> <a href="cadastrar_funcionarios.jsp">CADASTRAR FUNCIONÁRIOS</a> <a href="#"><span class="div_menu">|</span></a> <a href="cadastrar_produtos.jsp">CADASTRAR PRODUTOS</a> </div></td>
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
    <td colspan="5" valign="top"><form name="formManutFor" method="post"
    onSubmit="return validarFieldCadFor(this);"  action="cadastrar_fornecedores.jsp?acao=1">
      <table width="520" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td valign="top"><fieldset>
            <legend class="formato_label">Formulário para Cadastrar Fornecedores.<br />
            <br />
            </legend>
            <table width="500" border="0" cellspacing="0" cellpadding="0">

              <tr>
                <td width="120"><div align="right"><span class="formato_label">ID:</span></div></td>
                <td width="15" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="339" align="center"><div align="left">
                <input name="id_forCadastro" id="id_forCadastro" type="text" id="id" size="10"
                       style="text-align:right"
                    value="<%
                        if(control.getIdFornecedor()>0){
                           out.write(String.format("%03d",control.getIdFornecedor()));
                                   }else{
                out.write("");
                };
                            %>"

                       readonly="true"/>
                </div></td>
              </tr>

              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>

              <tr>
                <td width="167"><div align="right"><span class="formato_label">Razão Social:</span></div></td>
                <td width="27" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="339" align="center"><div align="left">
                  <input name="razao_social" id="razao_social" type="text" id="nome" size="30"
                         maxlength="45"
                         onkeyup="removeCaractresSpeciais(this);"
                         value="<%
                         if(control.getRazaoSocial()!=null)
                         out.write(control.getRazaoSocial());
                         %>" onblur="validaVazio(this,document.getElementById('razao_social_help'));"/>
                  <span id="razao_social_help" class="help"></span>
                </div></td>
              </tr>


              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>

              <tr>
                <td width="167"><div align="right"><span class="formato_label">Nome Fantasia:</span></div></td>
                <td width="27" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="252" align="center"><div align="left">
                  <input name="nome_fantasia" type="text" id="nome_fantasia" size="30"
                         maxlength="60"
                         onkeyup="removeCaractresSpeciais(this);"
                         value="<%
                         if(control.getNome()!=null)
                         out.write(control.getNome());
                         %>"
                         onblur="validaVazio(this,document.getElementById('nome_fantasia_help'));"/>
                  <span id="nome_fantasia_help" class="help"></span>
                </div></td>
              </tr>

              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td align="center"><div align="right"><span class="formato_label">CNPJ:</span></div></td>
                <td align="center"><label>

                    <div align="left"></div>
                </label>                </td>
                <td align="center"><div align="left">
                  <input name="cnpj" type="text" id="email" size="30"
                         onkeyup="removeCaractresSpeciais(this);"
                         maxlength="20" onkeypress="mascara(this,soNumeros);"
                         value="<%
                         if(control.getCNPJ()!=null)
                         out.write(control.getCNPJ());
                         %>"
                         onblur="validaVazio(this,document.getElementById('cnpj_help'));"/>
                  <span id="cnpj_help" class="help"></span>
                </div></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><div align="right"><span class="formato_label">Nome para Contato:</span></div></td>
                <td><label>

                    <div align="left"></div>
                </label></td>
                <td><input type="text" name="nome_contato" id="nome_contato"
                           maxlength="45" size="30"
                           onkeyup="removeCaractresSpeciais(this);"
                           value="<%
                         if(control.getContato()!=null)
                         out.write(control.getContato());
                         %>"
                         onblur="validaVazio(this,document.getElementById('nome_contato_help'));"/>
                <span id="nome_contato_help" class="help"></span>
                </td>
              </tr>
              <tr>
                <td><div align="right"></div></td>
                <td><div align="center"></div></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><div align="right"><span class="formato_label">Telefone:</span></div></td>
                <td>
                  <div align="left"></div></td>
                <td><input type="text" name="telefone_forn" id="telefone_forn"
                           maxlength="15" size="30"
                           onkeyup="removeCaractresSpeciais(this);"
                           onkeypress="mascara(this,soNumeros);"
                           value="<%
                         if(control.getTelefone()!=null)
                         out.write(control.getTelefone());
                         %>"
                         onblur="validaVazio(this,document.getElementById('telefone_forn_help'));"/>
                <span id="telefone_forn_help" class="help"></span>
                </td>
              </tr>
              <tr>
                <td><div align="right"></div></td>
                <td><div align="center"></div></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><div align="right"><span class="formato_label">E-mail:</span></div></td>
                <td>
                  <div align="left"></div></td>
                <td><input type="text" name="email_forn" id="email_func"
                           maxlength="45" size="30"
                           onkeyup="removeCaractresSpeciais(this);"
                           value="<%
                         if(control.getEmail()!=null)
                         out.write(control.getEmail());
                         %>"
                         onblur="validaVazio(this,document.getElementById('email_forn_help'));"/>
                <span id="email_forn_help" class="help"></span>
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><div align="right"></div></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>


                <td colspan="3" align="center">
                  <input type="submit" name="submit" id="submit" value="   Salvar   " class="inputstyle"/>
                  <input type="button" name="reset" id="reset"   value="   Cancelar/Novo " class="inputstyle" onclick="limparCamposFornecedores(this.form);"/>
                  <input type="button" name="excluir" id="excluir"   value="   Excluir  " class="inputstyle" onclick="excluirRegistroCadastro('cadastrar_fornecedores','id_fornecedor',document.getElementById('id_forCadastro').value,document.getElementById('razao_social').value);"/>
                  <input type="button" name="busca" id="busca"   value="    Busca   " class="inputstyle" onclick="buscaFornecedor();" />
                  <input type="button" name="voltar"  id="voltar" title="Clique para voltar à janela Anterior"  value="    Voltar  " class="inputstyle" onclick="javascript: window.history.go(-1);"/>
                 
                </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><div align="center"></div></td>
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