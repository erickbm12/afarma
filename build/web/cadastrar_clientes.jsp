<%-- 
    Document   : cadastrar_cadastrar_funcionarios
    Created on : 03/06/2015, 19:32:45
    Author     : Erick Medeiros
--%>
<script type="text/javascript" src="js/validaCadastros.js"></script>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*, com.afarma.controle.*"%>
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


            Cliente control = new Cliente();
            String acao = "0";
            acao = request.getParameter("acao");
    if(acao == null){
        acao = new  String();
    }
         ////// acao 01 para atualizar um registro ou inserir \\\\\\\

            if(acao.equals("1")){

                String idCli = "";
                idCli = request.getParameter("id_cliCadastro");

                if(idCli != ""){

                   control.setId_Cliente(Integer.parseInt(request.getParameter("id_cliCadastro")));
                   control.setNome(request.getParameter("nome_cli"));
                   control.setCPF(request.getParameter("cpf_cli"));
                   control.setRG(request.getParameter("rg_cli"));
                   control.setTelefone(request.getParameter("telefone_cli"));
                   control.setEmail(request.getParameter("email_cli"));
                   control.atualizarPontos(Integer.parseInt(request.getParameter("pontos_cli")));

                   control.atualizarCliente();
                    }


                if(idCli == ""){

                   control.setNome(request.getParameter("nome_cli"));
                   control.setCPF(request.getParameter("cpf_cli"));
                   control.setRG(request.getParameter("rg_cli"));
                   control.setTelefone(request.getParameter("telefone_cli"));
                   control.setEmail(request.getParameter("email_cli"));
                   control.atualizarPontos(Integer.parseInt(request.getParameter("pontos_cli")));

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
                 control.excluirCliente(request.getParameter("id_cliente"));
                   }
            ////////////////////////////// fim excluir \\\\\\\\\\\\\\\\\\\\\\\\
            ////////////////////////////// instanciar \\\\\\\\\\\\\\\\\\\\\\\\
                if(acao.equals("3")){
                   control.instanciarCliente(request.getParameter("id_cliente"));
                }
            ////////////////////////////// fim instanciar \\\\\\\\\\\\\\\\\\\\\\\\



%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::Cadastrar Funcionários::</title>
        <link href="estiloscss/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body onload="setarEdit('nome_cli')">
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
    <td height="25" colspan="5" bgcolor="#01A7D9"><div align="center"><a href="link_cadastros.jsp">JANELA PRINCIPAL</a>&nbsp; &nbsp;<a href="index.jsp">HOME</a> <a href="#"><span class="div_menu">|</span></a><a href="cadastrar_funcionarios.jsp"> CADASTRAR FUNCIONÁRIOS </a><a href="#"><span class="div_menu">|</span></a> <a href="cadastrar_fornecedores.jsp">CADASTRAR FORNECEDORES</a> <a href="#"><span class="div_menu">|</span></a> <a href="cadastrar_produtos.jsp">CADASTRAR PRODUTOS</a> </div></td>
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
    <td colspan="5" valign="top"><form name="formManutCli" method="post"
              onSubmit="return validarFieldCadCliente(this);" action="cadastrar_clientes.jsp?acao=1">
      <table width="524" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td valign="top"><fieldset>
            <legend class="formato_label">Cadastrar Clientes.<br />
            <br />
            </legend>
            <table width="446" border="0" cellspacing="0" cellpadding="0">

              <tr>
                <td width="92"><div align="right"><span class="formato_label">ID:</span></div></td>
                <td width="15" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="339" align="center"><div align="left">
                        <input name="id_cliCadastro" id="id_cliCadastro" type="text" id="id" size="10"
                               style="text-align:right"
                        value="<%
                        if(control.getId_Cliente()>0){
                           out.write(String.format("%03d",control.getId_Cliente()));
                                   }else{
                out.write("");
                };
                            %>" readonly="true"/>
                </div></td>
              </tr>


              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>

              <tr>
                <td width="92"><div align="right"><span class="formato_label">Nome:</span></div></td>
                <td width="15" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="339" align="center"><div align="left">
                  <input name="nome_cli" type="text" id="nome_cli" size="30" maxlength="60"
                         value="<%
                         if(control.getNome()!=null)
                         out.write(control.getNome());
                         %>"
                         onkeyup="removeCaractresSpeciais(this);"
                         onblur="validaVazio(this,document.getElementById('nome_cli_help'));"/>
                  <span id="nome_cli_help" class="help"></span>
                </div></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td align="center"><div align="right"><span class="formato_label">CPF:</span></div></td>
                <td align="center"><label>

                    <div align="left"></div>
                </label>                </td>
                <td align="center"><div align="left">
                  <input name="cpf_cli" type="text" id="email" size="30" maxlength="11"
                  onkeyup="removeCaractresSpeciais(this);"
                  onkeypress="mascara(this,soNumeros)"
                  value="<%
                         if(control.getCPF()!=null)
                         out.write(control.getCPF());
                         %>"
                onblur="validaVazio(this,document.getElementById('cpf_cli_help'));"
                         />
                  <span id="cpf_cli_help" class="help"></span>
                </div></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><div align="right"><span class="formato_label">RG:</span></div></td>
                <td><label>

                    <div align="left"></div>
                </label></td>
                <td><input type="text" name="rg_cli" id="rg_cli" maxlength="8" size="30"
                           onkeyup="removeCaractresSpeciais(this);"
                         value="<%
                         if(control.getRG()!=null)
                         out.write(control.getRG());
                         %>"
                         onblur="validaVazio(this,document.getElementById('rg_cli_help'));"/>
                <span id="rg_cli_help" class="help"></span>
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
                <td><input type="text" name="telefone_cli" id="telefone_cli" maxlength="15" size="30"
                           onkeyup="removeCaractresSpeciais(this);"
                     onkeypress="mascara(this,soNumeros);"
                           value="<%
                         if(control.getTelefone()!=null)
                         out.write(control.getTelefone());
                         %>"
                         onblur="validaVazio(this,document.getElementById('telefone_cli_help'));"/>
                <span id="telefone_cli_help" class="help"></span>
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
                <td><input type="text" name="email_cli" id="email_func" maxlength="45" size="30"
                           onkeyup="removeCaractresSpeciais(this);"
                         value="<%
                         if(control.getEmail()!=null)
                         out.write(control.getEmail());
                         %>"
                         onblur="validaVazio(this,document.getElementById('email_cli_help'));"/>
                <span id="email_cli_help" class="help"></span>
                </td>
              </tr>

              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>


              <tr>
                <td width="92"><div align="right"><span class="formato_label">Pontos:</span></div></td>
                <td width="15" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="339" align="center"><div align="left">
               <input  name="pontos_cli" type="text" id="pontos_cli" 
                size="10" readonly="true"
                style="text-align:right"
                value="<%if(control.getNumeroPontos()>0){
                out.write(String.format("%03d",control.getNumeroPontos()));
                }else{
                out.write("0");
                };%>"
                />
                </div></td>
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
                <td><div align="right"></div></td>
                
                <td colspan="2" align="center">
                  <input type="submit" name="submit" id="submit" value="  Salvar    " class="inputstyle"/>
                  <input type="button" name="reset" id="reset"   value="  Cancelar/Novo " class="inputstyle" onclick="limparCamposClientes(this.form);"/>
                  <input type="button" name="excluir" id="excluir"   value="   Excluir  " class="inputstyle" onclick="excluirRegistroCadastro('cadastrar_clientes','id_cliente',document.getElementById('id_cliCadastro').value,document.getElementById('nome_cli').value);"/>
                  <input type="button" name="busca" id="busca"   value="   Busca    " class="inputstyle" onclick="buscaCliente();" />
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