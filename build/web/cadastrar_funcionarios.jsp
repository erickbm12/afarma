<%-- 
    Document   : cadastrar_cadastrar_funcionarios
    Created on : 05/06/2015, 19:32:46
    Author     : Erick Medeiros
--%>

<script type="text/javascript" src="js/validaCadastros.js"></script>
<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" import="java.util.*, com.afarma.controle.*"%>
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
  
            Funcionario control = new Funcionario();
            String acao = "0";
            acao = request.getParameter("acao");
    if(acao == null){
        acao = new  String();
    }
         ////// acao 01 para atualizar um registro ou inserir \\\\\\\

            if(acao.equals("1")){

                String idFun = "";
                String tipo = "0";
                tipo = request.getParameter("tipo");
                idFun = request.getParameter("id_funcCadastro");
                




                if(idFun != ""){
                

                   control.setIdFuncionario(Integer.parseInt(request.getParameter("id_funcCadastro")));
                   control.setNome(request.getParameter("nome_func"));
                   control.setCPF(request.getParameter("cpf_func"));
                   control.setRG(request.getParameter("rg_func"));
                   control.setTelefone(request.getParameter("telefone_func"));
                   control.setEmail(request.getParameter("email"));
                   control.setSenha(request.getParameter("senha_func"));
                   control.setEndereco(request.getParameter("endereco_func"));

                   if(tipo.equals("1")){
                    control.setPerfilAdm(true);
                       }else{
                    control.setPerfilAdm(false);
                       }
                   control.atualizarFuncionario();
                    }


                if(idFun == ""){                

                   control.setNome(request.getParameter("nome_func"));
                   control.setCPF(request.getParameter("cpf_func"));
                   control.setRG(request.getParameter("rg_func"));
                   control.setTelefone(request.getParameter("telefone_func"));
                   control.setEmail(request.getParameter("email"));
                   control.setSenha(request.getParameter("senha_func"));
                   control.setEndereco(request.getParameter("endereco_func"));
                   if(tipo.equals("1")){
                    control.setPerfilAdm(true);
                       }else{
                    control.setPerfilAdm(false);
                       }
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


            /////// acao para excluir um registro \\\\\\\
////////////////////////////// excluir \\\\\\\\\\\\\\\\\\\\\\\\
     if(acao.equals("2")){
       control.excluirFuncionario(request.getParameter("id_func"));
         }
////////////////////////////// fim excluir \\\\\\\\\\\\\\\\\\\\\\\\
////////////////////////////// instanciar \\\\\\\\\\\\\\\\\\\\\\\\
            if(acao.equals("3")){
                   control.instanciarFuncionario(request.getParameter("id_func"),1);
                }
////////////////////////////// fim instanciar \\\\\\\\\\\\\\\\\\\\\\\\
%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::Cadastrar Funcionários e Administrador::</title>
       <link href="estiloscss/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body onload="setarEdit('nome_func')">
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
    <td height="25" colspan="5" bgcolor="#01A7D9"><div align="center"><a href="link_cadastros.jsp">JANELA PRINCIPAL</a>&nbsp; &nbsp;<a href="index.jsp">HOME</a> <a href="#"><span class="div_menu">|</span></a><a href="cadastrar_clientes.jsp"> CADASTRAR CLIENTES </a><a href="#"><span class="div_menu">|</span></a> <a href="cadastrar_fornecedores.jsp">CADASTRAR FORNECEDORES</a> <a href="#"><span class="div_menu">|</span></a> <a href="cadastrar_produtos.jsp">CADASTRAR PRODUTOS</a> </div></td>
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
    <td colspan="5" valign="top">
        <form id="formManutFun" name="formManutFun" method="post"
           onSubmit="return validarFieldCadFun(this);"  action="cadastrar_funcionarios.jsp?acao=1">
      <table width="524" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td valign="top"><fieldset>
            <legend class="formato_label">Formulário para Cadastrar Funcionários..<br />
            <br />
            </legend>
            <table width="446" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="92"><div align="right"><span class="formato_label">ID:</span></div></td>
                <td width="15" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="339" align="center"><div align="left">

                        <input name="id_funcCadastro" id="id_funcCadastro" type="text" id="id" size="10"
                               style="text-align:right"
                        value="<%
                        if(control.getIdFuncionario()>0){
                           out.write(String.format("%03d",control.getIdFuncionario()));
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

                  <input name="nome_func" type="text" id="nome_func" maxlength="60"
                         onkeyup="removeCaractresSpeciais(this);"
                         value="<%
                         if(control.getNome()!=null)
                         out.write(control.getNome());
                         %>"
                         onblur="validaVazio(this,document.getElementById('nome_help'));"
                         size="30"/><span id="nome_help" class="help"></span>
                </div></td>



              </tr>

              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>

              <tr>
                <td width="92"><div align="right"><span class="formato_label">Endereco:</span></div></td>
                <td width="15" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="339" align="center"><div align="left">

                        <input name="endereco_func" type="text" maxlength="45"
                               onkeyup="removeCaractresSpeciais(this);"
                         value="<%
                         if(control.getEndereco()!=null)
                         out.write(control.getEndereco());
                         %>" 
                         onblur="validaVazio(this,document.getElementById('endereco_help'));"
                         size="30" /><span id="endereco_help" class="help"></span>
 
                 
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

                  <input name="cpf_func" type="text"  size="30" maxlength="11"
                         onkeyup="removeCaractresSpeciais(this);"
                         onkeypress="mascara(this,soNumeros);"
                         value="<%
                         if(control.getCPF()!=null)
                         out.write(control.getCPF());
                         %>"   onkeypress="mascara(this,soNumeros);" 
                         onblur="validaVazio(this,document.getElementById('cpf_help'));"
                         size="30"/>
                         <span id="cpf_help" class="help"></span>
                  
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

                <td><input type="text" name="rg_func" id="rg_func" maxlength="8"
                           onkeyup="removeCaractresSpeciais(this);"
                   value="<%
                         if(control.getRG()!= null)
                         out.write(control.getRG());
                         %>" 
                         onblur="validaVazio(this,document.getElementById('rg_help'));"
                         size="30"/>
                <span id="rg_help" class="help"></span>
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
 
                <td><input type="text" name="telefone_func" id="telefone_func" maxlength="15"
                           value="<%
                         if(control.getTelefone()!= null)
                         out.write(control.getTelefone());
                         %>"
                           onkeyup="removeCaractresSpeciais(this);"
                           onkeypress="mascara(this,soNumeros);" 
                           onblur="validaVazio(this,document.getElementById('telefone_help'));"
                         size="30"/>
                <span id="telefone_help" class="help"></span>
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

                <td><input type="text" name="email" maxlength="45"
                           onkeyup="removeCaractresSpeciais(this);"
                           value="<%
                         if(control.getEmail()!= null)
                         out.write(control.getEmail());
                         %>"
                       onblur="validaVazio(this,document.getElementById('email_help'));"
                         size="30"/>
                    <span id="email_help" class="help"></span>
                         </td>

              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><div align="right"><span class="formato_label">Senha:</span></div></td>
                <td>&nbsp;</td>
                <td><input name="senha_func" type="password" id="senha_func" size="10"
                           onkeyup="removeCaractresSpeciais(this);"
                           value="<%
                         if(control.getSenha()!= null)
                         out.write(control.getSenha());
                         %>"onblur="validaVazio(this,document.getElementById('senha_help'));"
                         size="30"/>
                <span id="senha_help" class="help"></span>

                </td>
              </tr>

              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>

              <tr>
                  <td></td>
                  <td></td>
                  <td><div align="left"><span class="formato_label">
                        <%
                        if(control.getPerfilAdm()){
                        %>
                        <input type="radio" name="tipo" value="1" checked="true">Administrador<br>
                        <input type="radio" name="tipo" value="0" >Funcionario
                        <%}%>
                       <% if(control.getPerfilAdm()==false){%>
                        <input type="radio" name="tipo" value="1" >Administrador<br>
                        <input type="radio" name="tipo" value="0" checked="true">Funcionario
                        <%
                        }
                        %>
                          
                          </span></div></td>

                  </tr>

              <tr>
                <td><div align="right"></div></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
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

                <td colspan="3" align="center">
                    <input type="submit" name="submit" id="submit" value="  Salvar  " class="inputstyle"/>
                    <input type="button" name="reset" id="reset"   value="  Cancelar/Novo " class="inputstyle" onclick="limparCamposFuncionarios(this.form);"/>
                    <input type="button" name="excluir" id="excluir"   value="   Excluir  " class="inputstyle" onclick="excluirRegistroCadastro('cadastrar_funcionarios','id_func',document.getElementById('id_funcCadastro').value,document.getElementById('nome_func').value);"/>
                    <input type="button" name="busca" id="busca"   value="   Busca   " class="inputstyle" onclick="buscaFuncionario();" />                    
                    <input type="button" name="voltar"  id="voltar" title="Clique para voltar à janela Anterior"  value="    Voltar  " class="inputstyle" onclick="javascript: window.history.go(-1);"/>

                </td>
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