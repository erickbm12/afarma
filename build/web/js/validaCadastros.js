
/* Validar campos Antes de Submeter */




function ExcluirVenda(id){
if(id=="000"){
    alert('Não Existe Venda instanciada para Excluir!');
    exit;
}

if(document.getElementById('fpg').disabled==true){
    alert('Venda Finalizada! Não é possível Excluir o Iten!');
    document.getElementById('fpg').focus();
    exit;
}

if(confirm('Deseja Excluir a Venda: '+id))
document.location.href="venda_produtos.jsp?acao=2&id_venda="+id;
}

function finalizarVenda(id, nItens, fpg){

if(nItens<=0){
    alert('Sem Produtos! Não é Possível Finalizar!');
    document.getElementById('id_produto').focus();
    exit;
}
if(document.getElementById('fpg').value=="00"){
    alert('Antes de Finalizar a Venda Favor Selecionar a Forma de PAGAMENTO!');
    document.getElementById('fpg').focus();
    exit;
}
if(document.getElementById('fpg').disabled==true){
    alert('A venda já Foi Finalizada!');
    document.getElementById('fpg').focus();
    exit;
}
if(confirm('Deseja Finalizar a Venda: '+id+' AGORA?'))
document.location.href="venda_produtos.jsp?acao=4&id_venda="+id+"&fpg="+fpg;
}


function emitirNotaFiscal(id){

if(document.getElementById('fpg').value=="00"){
    alert('Antes de Finalizar a Venda Favor Selecionar a Forma de PAGAMENTO!');
    document.getElementById('fpg').focus();
    exit;
}
if((document.getElementById('fpg').value!="00")&&(document.getElementById('fpg').disabled==false)){
    alert('Clique no Botão Finalizar e Finalize a Venda!');
    document.getElementById('fpg').focus();
    exit;
}

document.location.href="emissao_NotaFiscal.jsp?id_notaFiscal="+id;
}

function setarEdit(elementID){
document.getElementById(elementID).focus();
document.getElementById(elementID).select();
window.scrollTo(0, 100);
}



function excluirRegistroCadastro(janela, id_campo , id, registro){
    if(((id=="")||(registro==""))){
     alert('O Registro ainda não foi Salvo! Use o Botão CANCELAR para Limpar os Campos!');   
    }else{
    if(confirm('Deseja excluir o registro: '+registro+'?'))
     document.location.href=janela+".jsp?acao=2&"+id_campo+"="+parseInt(id);
    }
}

function excluirItemEntrada(id, registro){
    if(confirm('Deseja excluir o Item: '+registro+'?'))
     document.location.href="entrada_produtos.jsp?acao=34&id_produto="+id;
}

function excluirItemVenda(id, registro){
    if(confirm('Deseja excluir o Item: '+registro+'?'))
     document.location.href="venda_produtos.jsp?acao=34&id_produto="+id;
}

function validaInsercaoEntrada(form){
 var retorno = true;
  if((form.id_produto.value=="")){
 retorno = false;
 alert("Favor informar o Produto!");
 form.id_produto.focus();
 }else
 if((parseInt(form.id_produto.value)<=0)){
 retorno = false;
 alert("Favor informar o Produto!");
 form.id_produto.focus();
 }

 if((form.quantidade_produto.value=="")){
 retorno = false;
 alert("Favor informar a Quantidade!");
 form.quantidade_produto.focus();
 }else
  if((parseInt(form.quantidade_produto.value)<=0)){
 retorno = false;
 alert("Favor informar a Quantidade!");
 form.quantidade_produto.focus();
 }

 if((parseInt(form.valor_produto.value==""))){
 retorno = false;
 alert("Favor informar o valor do Produto!");
 form.valor_produto.focus();
 }else
 if((parseFloat(form.valor_produto.value)<=0)){
 retorno = false;
 alert("Favor informar o valor do Produto!");
 form.valor_produto.focus();
 }

 if((parseInt(form.valor_produtoVenda.value==""))){
 retorno = false;
 alert("Favor informar o valor de Venda!");
 form.valor_produtoVenda.focus();
 }else
 if((parseFloat(form.valor_produtoVenda.value)<=0)){
 retorno = false;
 alert("Favor informar o valor de Venda!");
 form.valor_produtoVenda.focus();
 }

 if((form.data_entrada.value == "")){
 retorno = false;
 alert("Favor informar a Data da Entrada!");
 form.data_entrada.focus();
 }else
 if((doDate(form.data_entrada.value,5)==false)){
 retorno = false;
 alert("Favor informar a Data da Entrada!");
 form.data_entrada.focus();
 }

 return retorno;

}

function validaInsercaoVenda(form){
 var retorno = true;
  if((form.id_produto.value=="")){
 retorno = false;
 alert("Favor informar o Produto!");
 form.id_produto.focus();
 }else
 if((parseInt(form.id_produto.value)<=0)){
 retorno = false;
 alert("Favor informar o Produto!");
 form.id_produto.focus();
 }

 if((form.quantidade_produto.value=="")){
 retorno = false;
 alert("Favor informar a Quantidade!");
 form.quantidade_produto.focus();
 }else
  if((parseInt(form.quantidade_produto.value)<=0)){
 retorno = false;
 alert("Favor informar a Quantidade!");
 form.quantidade_produto.focus();
 }

 return retorno;

}

function validarFieldCadFun(form){
var retorno = true;
if(form.nome_func.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.nome_func.focus();
}
if(form.endereco_func.value==""){
   retorno = false;
   alert("Favor preencher o campo!");
   form.endereco_func.focus();
}
if(form.cpf_func.value==""){
   retorno = false;
   alert("Favor preencher o campo!");
   form.cpf_func.focus();
}
if(form.rg_func.value==""){
   retorno = false;
   alert("Favor preencher o campo!");
   form.rg_func.focus();
}
if(form.email.value==""){
   retorno = false;
   alert("Favor preencher o campo!");
   form.email.focus();
}
if(form.telefone_func.value==""){
   retorno = false;
   alert("Favor preencher o campo!");
   form.telefone_func.focus();
}

 return retorno;
}

function validarFieldCadCliente(form){
var retorno = true;
if(form.nome_cli.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.nome_cli.focus();
}
if(form.cpf_cli.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.cpf_cli.focus();
}
if(form.rg_cli.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.rg_cli.focus();
}
if(form.telefone_cli.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.telefone_cli.focus();
}
if(form.email_cli.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.email_cli.focus();
}
if(form.pontos_cli.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.pontos_cli.focus();
}
 return retorno;
}

function validarFieldCadFor(form){
var retorno = true;
if(form.razao_social.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.razao_social.focus();
}
if(form.nome_fantasia.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.nome_fantasia.focus();
}
if(form.cnpj.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.cnpj.focus();
}
if(form.nome_contato.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.nome_contato.focus();
}
if(form.telefone_forn.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.telefone_forn.focus();
}
if(form.email_forn.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.email_forn.focus();
}
 return retorno;
}

function validarFieldCadProd(form){
var retorno = true;
if(form.nome_produto.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.nome_produto.focus();
}
if(form.descricao.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.descricao.focus();
}
if(form.laboratorio.value==""){
    retorno = false;
    alert("Favor preencher o campo!");
    form.laboratorio.focus();
}

if(form.valor_venda.value==""){
    retorno = false;
    alert("Favor preencher o campo Valor Invalido!");
    form.valor_venda.focus();
}/*else{
    if(parseFloat(form.valor_venda.value)<=0){
    retorno = false;
    alert("Favor preencher o campo com Valor maior que Zero!");
    form.valor_venda.focus();
    }*/
}

/* FIM Validar campos Antes de Submeter */

/* Validar campos Preenchido */

 function validaVazio(field, help){
     if(field.value.length==0){
         if(help != null)
             help.innerHTML = "PREENCHER!";
              return false;
     }else{
             help.innerHTML = "";
              return false;
     }
 }

/* FIM Validar campos Preenchido */

/* Limpar Campos  */
function limparCamposFuncionarios(form){
form.id_funcCadastro.value      ="";
form.nome_func.value    ="";
form.cpf_func.value     ="";
form.rg_func.value      ="";
form.email.value        ="";
form.telefone_func.value="";
form.endereco_func.value="";
form.senha_func.value   ="";
form.tipo[1].checked    = true;

}

function limparCamposClientes(form){
form.id_cliCadastro.value="";
form.nome_cli.value    ="";
form.cpf_cli.value     ="";
form.rg_cli.value      ="";
form.telefone_cli.value="";
form.email_cli.value   ="";
form.pontos_cli.value  ="0";
}

function limparCamposFornecedores(form){
form.id_forCadastro.value="";
form.razao_social.value  ="";
form.nome_fantasia.value ="";
form.cnpj.value          ="";
form.nome_contato.value  ="";
form.telefone_forn.value ="";
form.email_forn.value    ="";
}

function limparCamposProdutos(form){
form.id_proCadastro.value="";
form.nome_produto.value  ="";
form.descricao.value     ="";
form.laboratorio.value   ="";
form.valor_venda.value   ="0";
form.estoque.value       ="0";
}

function limparCamposEmissaoNotaFiscal(form){
form.id_notaFiscal.value="";
}

/* FIM Limpar Campos  */
/* Validar campos Numericos com Masccara ou Nao  */


function verificar_valor(e,args)
        {
                if (document.all){var evt=event.keyCode;} 
                else{var evt = e.charCode;}     
                var valid_chars = '0123456789'+args;    
                var chr= String.fromCharCode(evt);      
                if (valid_chars.indexOf(chr)>-1 ){return true;} 
                if (valid_chars.indexOf(chr)>-1 || evt < 20){return true;}     
                return false;   // do contrário nega
        }

/* FIM Validar campos Numericos com Masccara ou Nao  */

/* Chamar Janelas Localizar  */

function buscaCliente(){
    document.location.href="busca_cliente.jsp";
}
function buscaFornecedor(){
    document.location.href="busca_fornecedor.jsp";
}
function buscaFuncionario(){
    document.location.href="busca_funcionario.jsp";
}
function buscaProduto(){
    document.location.href="busca_produto.jsp";
}
function buscaNotaFiscal(){
    document.location.href="busca_venda_EmissaoNotaFiscal.jsp";
}
function buscaProdutoEntrada(){
    document.location.href="busca_produto_entrada.jsp";
}
function buscaProdutoVenda(){
    document.location.href="busca_produto_venda.jsp";
}
/* Chamar Janelas Localizar  */

//Inicio Funcoes de expressoes Regulares
function mascara(o,f){
    v_obj=o
    v_fun=f
    setTimeout("execmascara()",1)
}

function execmascara(){
    v_obj.value=v_fun(v_obj.value)
}

function leech(v){
    v=v.replace(/o/gi,"0")
    v=v.replace(/i/gi,"1")
    v=v.replace(/z/gi,"2")
    v=v.replace(/e/gi,"3")
    v=v.replace(/a/gi,"4")
    v=v.replace(/s/gi,"5")
    v=v.replace(/t/gi,"7")
    return v
}

function soNumeros(v){
    return v.replace(/\D/g,"")
}

function telefone(v){
    v=v.replace(/\D/g,"")                 
    v=v.replace(/^(\d\d)(\d)/g,"($1) $2") 
    v=v.replace(/(\d{4})(\d)/,"$1-$2")    
    return v
}

function cpf(v){
    v=v.replace(/\D/g,"")                   
    v=v.replace(/(\d{3})(\d)/,"$1.$2")       
    v=v.replace(/(\d{3})(\d)/,"$1.$2")      
                                             
    v=v.replace(/(\d{3})(\d{1,2})$/,"$1-$2") 
    return v
}

function cep(v){
    v=v.replace(/D/g,"")                
    v=v.replace(/^(\d{5})(\d)/,"$1-$2") 
    return v
}

function cnpj(v){
    v=v.replace(/\D/g,"")                           
    v=v.replace(/^(\d{2})(\d)/,"$1.$2")             
    v=v.replace(/^(\d{2})\.(\d{3})(\d)/,"$1.$2.$3") 
    v=v.replace(/\.(\d{3})(\d)/,".$1/$2")           
    v=v.replace(/(\d{4})(\d)/,"$1-$2")              
    return v
}

function dataMascara(v){
    v=v.replace(/\D/g,"")                    
    v=v.replace(/(\d{2})(\d)/,"$1/$2")       
    v=v.replace(/(\d{2})(\d)/,"$1/$2")       

    return v
}


function romanos(v){
    v=v.toUpperCase()             
    v=v.replace(/[^IVXLCDM]/g,"") 
    //Essa é complicada! Copiei daqui: http://www.diveintopython.org/refactoring/refactoring.html
    while(v.replace(/^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/,"")!="")
        v=v.replace(/.$/,"")
    return v
}

function site(v){

    v=v.replace(/^http:\/\/?/,"")
    dominio=v
    caminho=""
    if(v.indexOf("/")>-1)
        dominio=v.split("/")[0]
        caminho=v.replace(/[^\/]*/,"")
    dominio=dominio.replace(/[^\w\.\+-:@]/g,"")
    caminho=caminho.replace(/[^\w\d\+-@:\?&=%\(\)\.]/g,"")
    caminho=caminho.replace(/([\?&])=/,"$1")
    if(caminho!="")dominio=dominio.replace(/\.+$/,"")
    v="http://"+dominio+caminho
    return v
}

function removeCaractresSpeciais(texto){
  v=texto.value;
  v=v.replace(/([^A-Za-z0-9 .,!?:...%@\n])/g, "");
  texto.value = v;
}

function formataMoedaIngles(texto){
                v = texto.value;
                v=v.replace(/\D/g,"")
        v=v.replace(/[0-9]{12}/,"inválido")
        v=v.replace(/(\d{1})(\d{1,2})$/,"$1.$2")
                texto.value = v;
}


//// expressoes de Validacao

var reDigits = /^\d+$/;

function doDigits(pStr)
{
	if (reDigits.test(pStr)) {
		alert(pStr + " contém apenas dígitos.");
	} else if (pStr != null && pStr != "") {
		alert(pStr + " NÃO contém apenas dígitos.");
	}
}

var reDecimalPt = /^[+-]?((\d+|\d{1,3}(\.\d{3})+)(\,\d*)?|\,\d+)$/;
var reDecimalEn = /^[+-]?((\d+|\d{1,3}(\,\d{3})+)(\.\d*)?|\.\d+)$/;
var reDecimal = reDecimalPt;

function doDecimal(pStr, pLang)
{
	charDec = ( pLang != "En"? ",": "." );
	eval("reDecimal = reDecimal" + pLang);
	if (reDecimal.test(pStr)) {
		pos = pStr.indexOf(charDec);
		decs = pos == -1? 0: pStr.length - pos - 1;
		alert(pStr + " é um float válido (" + pLang + ") com " + decs + " decimais.");
	} else if (pStr != null && pStr != "") {
		alert(pStr + " NÃO é um float válido.");
	}
} // doDecimal

var reMoeda = /^\d{1,3}(\.\d{3})*\,\d{2}$/;

function doMoeda(pStr)
{
	if (reMoeda.test(pStr)) {
		alert(pStr + " é um valor financeiro válido.");
	} else if (pStr != null && pStr != "") {
		alert(pStr + " NÃO é um valor financeiro válido.");
	}
}

var reDate1 = /^\d{1,2}\/\d{1,2}\/\d{1,4}$/;
var reDate2 = /^[0-3]?\d\/[01]?\d\/(\d{2}|\d{4})$/;
var reDate3 = /^(0?[1-9]|[12]\d|3[01])\/(0?[1-9]|1[0-2])\/(19|20)?\d{2}$/;
var reDate4 = /^((0?[1-9]|[12]\d)\/(0?[1-9]|1[0-2])|30\/(0?[13-9]|1[0-2])|31\/(0?[13578]|1[02]))\/(19|20)?\d{2}$/;
var reDate5 = /^((0[1-9]|[12]\d)\/(0[1-9]|1[0-2])|30\/(0[13-9]|1[0-2])|31\/(0[13578]|1[02]))\/\d{4}$/;
var reDate = reDate4;

function doDate(pStr, pFmt)
{
    retorno = true;
	eval("reDate = reDate" + pFmt);
	if (reDate.test(pStr)) {

	} else if (pStr != null && pStr != "") {
		alert(pStr + " NÃO é uma data válida!");
                document.forms[0].data_entrada.focus();
                retorno = false;
	}
        return retorno;
} // doDate

var reTime1 = /^\d{2}:\d{2}$/;
var reTime2 = /^([0-1]\d|2[0-3]):[0-5]\d$/;
var reTime3 = /^(0[1-9]|1[0-2]):[0-5]\d$/;
var reTime4 = /^\d+:[0-5]\d:[0-5]\d$/;
var reTime5 = /^\d+:[0-5]\d:[0-5]\.\d{3}\d$/;

function doTime(pStr, pFmt)
{
	eval("reTime = reTime" + pFmt);
	if (reTime.test(pStr)) {
		alert(pStr + " é um horário/tempo válido.");
	} else if (pStr != null && pStr != "") {
		alert(pStr + " NÃO é um horário/tempo válido.");
	}
} // doTime

var reEmail1 = /^[\w!#$%&'*+\/=?^`{|}~-]+(\.[\w!#$%&'*+\/=?^`{|}~-]+)*@(([\w-]+\.)+[A-Za-z]{2,6}|\[\d{1,3}(\.\d{1,3}){3}\])$/;
var reEmail2 = /^[\w-]+(\.[\w-]+)*@(([\w-]{2,63}\.)+[A-Za-z]{2,6}|\[\d{1,3}(\.\d{1,3}){3}\])$/;
var reEmail3 = /^[\w-]+(\.[\w-]+)*@(([A-Za-z\d][A-Za-z\d-]{0,61}[A-Za-z\d]\.)+[A-Za-z]{2,6}|\[\d{1,3}(\.\d{1,3}){3}\])$/;
var reEmail = reEmail3;

function doEmail(pStr, pFmt)
{
	eval("reEmail = reEmail" + pFmt);
	if (reEmail.test(pStr)) {
		alert(pStr + " é um endereço de e-mail válido.");
	} else if (pStr != null && pStr != "") {
		alert(pStr + " NÃO é um endereço de e-mail válido.");
	}
} // doEmail


//// Fim expressoes de validacao

//Fim Funcoes de expressoes Regulares