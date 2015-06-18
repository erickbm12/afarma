<%-- 
    Document   : cadastrar_produtos
    Created on : 05/06/2015, 19:32:46
    Author     : Erick Medeiros
--%>
<script type="text/javascript" src="js/validaCadastros.js"></script>
<%@page contentType="text/html" pageEncoding="UTF-8"  import="java.util.*, java.text.DecimalFormat, com.afarma.controle.*"%>
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


            Produto control = new Produto();
            String acao = "0";
            DecimalFormat formatarDecimal = new DecimalFormat("###0.00");
            acao = request.getParameter("acao");
    if(acao == null){
        acao = new  String();
    }
         ////// acao 01 para atualizar um registro ou inserir \\\\\\\

            if(acao.equals("1")){

                String idProd = "";
                idProd = request.getParameter("id_proCadastro");

                if(idProd != ""){

                   control.setIdProduto(Integer.parseInt(request.getParameter("id_proCadastro")));
                   control.setNome(request.getParameter("nome_produto"));
                   control.setDescricao(request.getParameter("descricao"));
                   control.setLab(request.getParameter("laboratorio"));
                   control.setPreco(Double.parseDouble(request.getParameter("valor_venda")));
                   control.setQtd(Integer.parseInt(request.getParameter("estoque")));

                   control.atualizarProduto();
                    }


                if(idProd == ""){

                   control.setNome(request.getParameter("nome_produto"));
                   control.setDescricao(request.getParameter("descricao"));
                   control.setLab(request.getParameter("laboratorio"));
                   control.setPreco(Double.parseDouble(request.getParameter("valor_venda")));
                   control.setQtd(Integer.parseInt(request.getParameter("estoque")));

                   control.inserir();
                    }
                
          out.println("<SCRIPT language='JavaScript'>");
                   switch(control.getRetorno()){
                        case 1:
                            out.println("alert('Registro Incluído com Sucesso!');");
                            break;
                        case 2:
                            out.println("alert('Não foi possível Inserir: Produto já Cadastrado!');");
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
              control.excluirProduto(request.getParameter("id_produto"));
             }
////////////////////////////// fim excluir \\\\\\\\\\\\\\\\\\\\\\\\
////////////////////////////// instanciar \\\\\\\\\\\\\\\\\\\\\\\\
            if(acao.equals("3")){
                   control.instanciarProduto(request.getParameter("id_produto"));
                }
////////////////////////////// fim instanciar \\\\\\\\\\\\\\\\\\\\\\\\

%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>::Cadastrar Produtos::</title>
        <link href="estiloscss/estilos.css" rel="stylesheet" type="text/css">
    </head>
    <body onload="setarEdit('nome_produto')">
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
  onsubmit="return validarFieldCadProd(this)" action="cadastrar_produtos_entrada.jsp?acao=1">
      <table width="524" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td valign="top"><fieldset>
            <legend class="formato_label">Formulário para Cadastrar Produtos:<br />
            <br />
            </legend>
            <table width="500" border="0" cellspacing="0" cellpadding="0">

              <tr>
                <td width="92"><div align="right"><span class="formato_label">ID:</span></div></td>
                <td width="15" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="339" align="center"><div align="left">
                <input name="id_proCadastro" type="text" id="id" size="10" readonly="true"
                       style="text-align:right"
                        value="<%
                        if(control.getIdProduto()>0){
                           out.write(String.format("%03d",control.getIdProduto()));
                                   }else{
                out.write("");
                };
                            %>"/>
                </div></td>
              </tr>

              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>

              <tr>
                <td width="167"><div align="right"><span class="formato_label">Nome do Produto:</span></div></td>
                <td width="27" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="252" align="center"><div align="left">
                  <input name="nome_produto" type="text" id="nome_produto" size="30"
                         maxlength="45"
                         value="<%
                         if(control.getNome()!=null)
                         out.write(control.getNome());
                         %>"
                         onkeyup="removeCaractresSpeciais(this);"
                         onblur="validaVazio(this,document.getElementById('nome_produto_help'));"/>
                  <span id="nome_produto_help" class="help"></span>
                </div></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td align="center"><div align="right"><span class="formato_label">Descrição:</span></div></td>
                <td align="center"><label>

                    <div align="left"></div>
                </label>                </td>
                <td align="center"><div align="left">
                  <input name="descricao" type="text" id="email" size="30"
                         maxlength="45"
                         value="<%
                         if(control.getDescricao()!=null)
                         out.write(control.getDescricao());
                         %>"
                         onkeyup="removeCaractresSpeciais(this);"
                         onblur="validaVazio(this,document.getElementById('descricao_help'));"/>
                  <span id="descricao_help" class="help"></span>
                </div></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td><div align="right"><span class="formato_label">Laboratório:</span></div></td>
                <td><label>

                    <div align="left"></div>
                </label></td>
                <td><input type="text" name="laboratorio" id="laboratorio"
                    maxlength="45"    value="<%
                         if(control.getLab()!=null)
                         out.write(control.getLab());
                         %>"
                         onkeyup="removeCaractresSpeciais(this);"
                         onblur="validaVazio(this,document.getElementById('laboratorio_help'));"/>
                <span id="laboratorio_help" class="help"></span>
                </td>
              </tr>


              <tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>

              <tr>
                <td width="167"><div align="right"><span class="formato_label">Valor Venda:</span></div></td>
                <td width="27" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="252" align="center"><div align="left">
                  <input name="valor_venda" type="text" id="valor_venda" size="10"
                         style="text-align:right"
                         maxlength="10" onkeyup="formataMoedaIngles(this);"
                         value="<%
                        if(control.getPreco()>0){
                           out.write(formatarDecimal.format(control.getPreco()).replace(',','.'));
                                   }else{
                out.write("0");
                };
                            %>"
                 onblur="validaVazio(this,document.getElementById('valor_venda_help'));"/>
                  <span id="valor_venda_help" class="help"></span>
                </div></td>
              </tr>

<tr>
                <td>&nbsp;</td>
                <td><label></label>                  </td>
                <td>&nbsp;</td>
              </tr>

              <tr>
                <td width="167"><div align="right"><span class="formato_label">Estoque:</span></div></td>
                <td width="27" align="center"><label>

                    <div align="left"></div>
                </label>                  </td>
                <td width="252" align="center"><div align="left">
                  <input name="estoque" type="text" id="estoque" size="10" 
                         readonly="true" value="0" maxlength="10"
                         style="text-align:right"
                                                 value="<%
                        if(control.getIdProduto()>0){
                           out.write(String.format("%03d",control.getQtdEstoque()));
                                   }else{
                out.write("0");
                };
                            %>"/>
                </div></td>
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
                <td colspan="3" align="center">
                  <input type="submit" name="submit" id="submit" value="   Salvar   " class="inputstyle"/>
                  <input type="button" name="reset" id="reset"   value="   Cancelar/Novo " class="inputstyle" onclick="limparCamposProdutos(this.form);"/>
                  <input type="button" name="excluir" id="excluir"   value="   Excluir  " class="inputstyle" onclick="excluirRegistroCadastro('cadastrar_produtos','id_produto',document.getElementById('id_proCadastro').value,document.getElementById('nome_produto').value);"/>
                  <input type="button" name="busca" id="busca"   value="    Busca   " class="inputstyle" onclick="buscaProduto();"/>
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