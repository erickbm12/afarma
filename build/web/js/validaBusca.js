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

function soNumerosID(v){
    if(document.forms[0].tipo[0].checked==false){
        exit;   
    }
    return v.replace(/\D/g,"")
}

function soNumerosIDCliFor(v){
    if((document.forms[0].tipo[0].checked==true)||(document.forms[0].tipo[1].checked==true)){
        return v.replace(/\D/g,"")
        exit;
    }
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

function doDateBusca(pStr, pFmt)
{retorno = true;
	eval("reDate = reDate" + pFmt);
	if (reDate.test(pStr)) {

	} else if (pStr != null && pStr != "") {
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


function voltar(){
  history.go(-1);
}

function excluirFornecedor(id, registro){
    if(confirm('Deseja excluir o registro: '+registro+'?'))
     document.location.href="busca_fornecedor.jsp?acao=2&id_fornecedor="+id;
}

function excluirProduto(id, registro){
    if(confirm('Deseja excluir o registro: '+registro+'?'))
     document.location.href="busca_produto.jsp?acao=2&id_produto="+id;
}

function excluirCliente(id, registro){
    if(confirm('Deseja excluir o registro: '+registro+'?'))
     document.location.href="busca_cliente.jsp?acao=2&id_cliente="+id;
}

function excluirFuncionario(id, registro){
    if(confirm('Deseja excluir o registro: '+registro+'?'))
     document.location.href="busca_funcionario.jsp?acao=2&id_func="+id;
}

function excluirEntrada(id, registro){
    if(confirm('Deseja excluir a Entrada: '+id+' '+ registro+'?'))        
     document.location.href="busca_entradas.jsp?acao=2&id_entrada="+id;
}

function novaEntrada(id){
     document.location.href="busca_fornecedor_entrada.jsp?acao=2&id_fornecedor="+id;
}

function novaVenda(id){
     document.location.href="busca_cliente_venda.jsp?acao=2&id_cliente="+id;
}

function enviar(form){
if(form.editConteudo.value==""){
 alert("Favor preencher o campo!");
 form.editConteudo.focus();
 exit;
}
form.submit();
 }

function enviarLocComDatas(form){
if(form.editConteudo.value==""){
 alert("Favor preencher o campo!");
 form.editConteudo.focus();
 exit;
}
if(form.tipo[2].checked){
 if((form.editConteudo.value == "")){
 alert("Favor informar a Data da Esquerda!");
 form.editConteudo.focus();
 exit;
 }else
 if((doDateBusca(form.editConteudo.value,5)==false)){
 alert("Favor informar a Data da Esquerda!");
 form.editConteudo.focus();
 exit;
 }

 if((form.editParaLoc.value == "")){
 alert("Favor informar a Data da Direita!");
 formmascara(this,soNumeros);
 form.editParaLoc.focus();
 exit;
 }else
 if((doDateBusca(form.editParaLoc.value,5)==false)){
 alert("Favor informar a Data da Direita!");
 formmascara(this,soNumeros);
 form.editParaLoc.focus();
 exit;
 }
}
form.submit();
 }

function enviarLocComDatasNF(form){
if(form.editConteudo.value==""){
 alert("Favor preencher o campo!");
 form.editConteudo.focus();
 exit;
}

 if((form.editDeLoc.value == "")){
 alert("Favor informar a Data da Esquerda!");
 form.editDeLoc.focus();
 exit;
 }else
 if((doDateBusca(form.editDeLoc.value,5)==false)){
 alert("Favor informar a Data da Esquerda!");
 form.editDeLoc.focus();
 exit;
 }

 if((form.editParaLoc.value == "")){
 alert("Favor informar a Data da Direita!");
 formmascara(this,soNumeros);
 form.editParaLoc.focus();
 exit;
 }else
 if((doDateBusca(form.editParaLoc.value,5)==false)){
 alert("Favor informar a Data da Direita!");
 formmascara(this,soNumeros);
 form.editParaLoc.focus();
 exit;
 }

form.submit();
 }

function descLabelProduto(form){
    if(form.tipo[0].checked)
     document.getElementById("descRadio").innerHTML="Digite o ID:";

    if(form.tipo[1].checked)
     document.getElementById("descRadio").innerHTML="Digite qualquer parte do Nome:";

    if(form.tipo[2].checked)
     document.getElementById("descRadio").innerHTML="Digite qualquer parte da Descricao:";

     if(form.tipo[3].checked)
     document.getElementById("descRadio").innerHTML="Digite qualquer parte do Laboratorio:";

 limparEdit(form);
}

function descLabelFornecedor(form){
    if(form.tipo[0].checked)
     document.getElementById("descRadio").innerHTML="Digite o ID:";

    if(form.tipo[1].checked)
     document.getElementById("descRadio").innerHTML="Digite o CNPJ do Fornecedor:";

    if(form.tipo[2].checked)
     document.getElementById("descRadio").innerHTML="Digite qualquer parte do Nome Fantasia:";

    if(form.tipo[3].checked)
     document.getElementById("descRadio").innerHTML="Digite qualquer parte da Razão Social:";
 
 limparEdit(form);
}

function descLabelVendas(form){

    if(form.tipo[0].checked){
     document.getElementById("descRadio").innerHTML="Digite o ID da Venda:";
     document.getElementById("editConteudo").size=40;
     document.getElementById("editConteudo").maxLength=10;
     document.getElementById("editParaLoc").value="";
     document.getElementById("editParaLoc").readOnly=true;
     document.getElementById("editParaLoc").type="hidden";

    }

    if(form.tipo[1].checked){
     document.getElementById("descRadio").innerHTML="Digite qualquer parte do Nome do Cliente:";
     document.getElementById("editConteudo").size=40;
     document.getElementById("editConteudo").maxLength=100;
     document.getElementById("editParaLoc").value="";
     document.getElementById("editParaLoc").readOnly=true;
     document.getElementById("editParaLoc").type="hidden";

    }

    if(form.tipo[2].checked){
     document.getElementById("descRadio").innerHTML="Digite o Período:";
     document.getElementById("editConteudo").size=10;
     document.getElementById("editConteudo").maxLength=10;
     document.getElementById("editParaLoc").readOnly=false;
     document.getElementById("editParaLoc").type="text";

    }

 limparEdit(form);
}

function descLabelEntradas(form){
    
    if(form.tipo[0].checked){
     document.getElementById("descRadio").innerHTML="Digite o ID da Entrada:";
     document.getElementById("editConteudo").size=40;
     document.getElementById("editConteudo").maxLength=10;
     document.getElementById("editParaLoc").value="";
     document.getElementById("editParaLoc").readOnly=true;     
     document.getElementById("editParaLoc").type="hidden";

    }

    if(form.tipo[1].checked){
     document.getElementById("descRadio").innerHTML="Digite qualquer parte do Nome Fantasia:";
     document.getElementById("editConteudo").size=40;
     document.getElementById("editConteudo").maxLength=100;
     document.getElementById("editParaLoc").value="";     
     document.getElementById("editParaLoc").readOnly=true;
     document.getElementById("editParaLoc").type="hidden";

    }

    if(form.tipo[2].checked){
     document.getElementById("descRadio").innerHTML="Digite o Período:";
     document.getElementById("editConteudo").size=10;
     document.getElementById("editConteudo").maxLength=10;
     document.getElementById("editParaLoc").readOnly=false;
     document.getElementById("editParaLoc").type="text";

    }

 limparEdit(form);
}

function descLabel(form){
    if(form.tipo[0].checked)
     document.getElementById("descRadio").innerHTML="Digite o ID:";

    if(form.tipo[1].checked)
     document.getElementById("descRadio").innerHTML="Digite qualquer parte do Nome:";

 limparEdit(form);
}

function descLabelCliente(form){
    if(form.tipo[0].checked)
     document.getElementById("descRadio").innerHTML="Digite o ID:";

    if(form.tipo[1].checked)
     document.getElementById("descRadio").innerHTML="Digite o CPF do Cliente:";

    if(form.tipo[2].checked)
     document.getElementById("descRadio").innerHTML="Digite qualquer parte do Nome:";

 limparEdit(form);
}

function limparEdit(form){
 form.editConteudo.value="";
 form.editConteudo.focus();    
}

function setarTipo(){
document.forms[0].tipo[0].checked=true;
document.getElementById("editConteudo").focus();
document.getElementById("editConteudo").select();
window.scrollTo(0, 100);
}

function setarTipoCliFor(){
document.forms[0].tipo[1].checked=true;
document.getElementById("editConteudo").focus();
document.getElementById("editConteudo").select();
window.scrollTo(0, 100);
}

function setarTipoLocEmissaoNotaFiscal(){
document.getElementById("editConteudo").focus();
document.getElementById("editConteudo").select();
window.scrollTo(0, 100);
}
