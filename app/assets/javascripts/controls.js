var controls;
var htmlTemplates;

$(function() {
  load_masks();
  onFilterCheckboxSelect();
  $('.m-select2').select2();
});


function ajaxStart(){

  KTApp.block('body', {
                message: 'Aguarde',
                overlayColor: '#000000',
                type: 'loader',
                state: 'primary'
            });
}

function ajaxStop(){
  KTApp.unblock();
}


function showLoading(target,message){

  KTApp.block(target, { message: message,
                overlayColor: '#000000',
                type: 'loader',
                state: 'primary'});

}

function stopLoading(){
  ajaxStop()
}

function showSuccessConfirmation(message){

    swal.fire({
        position: 'top-right',
        type: 'success',
        title: message,
        showConfirmButton: false,
        timer: 2000
    });
        
}


function set_visible(element,show){
  if (show)
    element.show();
  else
    element.hide();
}

function load_masks(){
  $('.cnpj-mask').mask('99.999.999/9999-99');
  $('.date-mask').mask('99/99/9999');
  $('.month-year-mask').mask('99/9999');
  $('.month-year-mask-short').mask('99/99');
  $('.time-mask').mask('00:00:00');
  $('.date_time-mask').mask('00/00/0000 00:00:00');
  $('.cep-mask').mask('00000-000');
  $('.phone-mask').mask('0000-0000');
  $('.phone_with_ddd-mask').mask('(00) 00000-0000');
  $('.phone_with_ddi').mask('+00(00) 00000-0000');
  $('.cell_phone-mask').mask('00000-0000');
  $('.cell_phone_with_ddd-mask').mask('(00)00000-0000');
  $('.phone_us-mask').mask('(000) 000-0000');
  $('.mixed-mask').mask('AAA 000-S0S');
  $('.state-mask').mask('AA');
  $('.uf-mask').mask('AA');
  $('.cpf-mask').mask('000.000.000-00', {reverse: true});
  $('.money-mask').mask('000.000.000.000.000,00', {reverse: true});
  $('.money2-mask').mask("#.##0.00", {reverse: true, maxlength: false});
  $('.integer-mask').mask("##");
  $('.word-mask').mask("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",{reverse: true, maxlength: false, optional: true});
  $('.ip_address-mask').mask('0ZZ.0ZZ.0ZZ.0ZZ', {translation: {'Z': {pattern: /[0-9]/, optional: true}}});
  $('.ip_address-mask').mask('099.099.099.099');
  $('.percent-mask').mask('##0.00', {reverse: true});
  $('.float-mask').mask('00.00', {reverse: true});
  $('.currency-mask').maskMoney();
  $('.cost-center').mask('00.00.00.000.000');
}

function onFilterCheckboxSelect() {
  $('.checklist > span input[type="checkbox"]').change(function() {
    if(this.checked) {
      $(this).parent().addClass('selected');
    }
    else {
      $(this).parent().removeClass('selected');
    }
  });
}


function validate_fields(context){
  error_count = 0;
  $(context+' .form-group').children('span.text-danger').remove();
  $(context+' .form-group').removeClass('has-error');  

  $(context+' input[type=email]').each(function(){
    email = $(this).val();
    if (! $(this).val().trim() == ''){
      if (! validate_email(email) ){
        add_error($(this),'email inválido');
        error_count += 1;
      }
    }
  });

  $(context+' input[data-validation=cpf]').each(function(){
    cpf = $(this).val();
    if (! $(this).val().trim() == ''){
      if (! validate_cpf(cpf) ){
        add_error($(this),'CPF inválido');
        error_count += 1;
      }
    }
  });

  $(context+' input[data-validation=date]').each(function(){
    date = $(this).val();
    if (! $(this).val().trim() == ''){
      if (! validate_date(date) ){
        add_error($(this),'Data inválida');
        error_count += 1;
      }
    }
  });


  return (error_count == 0);
}

function add_error(element,msg){
  group = $(element).parent('.form-group');
  if (group.length == 0) {
    group = $(element).parent('.input-group').parent('.form-group');
  }

  divError = group.find('div.with-errors');

  group.addClass('has-error');
  html_msg = "<span class='text-danger' style='display:inline;'>"+msg+"</span>"
  divError.html(html_msg);
}

function validate_cpf(cpf) {
   cpf = cpf.replace(/\./g,'').replace(/\-/g,'');
   var numeros, digitos, soma, i, resultado, digitos_iguais;
      digitos_iguais = 1;
      if (cpf.length < 11)
            return false;
      for (i = 0; i < cpf.length - 1; i++)
            if (cpf.charAt(i) != cpf.charAt(i + 1))
                  {
                  digitos_iguais = 0;
                  break;
                  }
      if (!digitos_iguais)
            {
            numeros = cpf.substring(0,9);
            digitos = cpf.substring(9);
            soma = 0;
            for (i = 10; i > 1; i--)
                  soma += numeros.charAt(10 - i) * i;
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(0))
                  return false;
            numeros = cpf.substring(0,10);
            soma = 0;
            for (i = 11; i > 1; i--)
                  soma += numeros.charAt(11 - i) * i;
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(1))
                  return false;
            return true;
            }
      else
            return false;
}


function list_validator(elements) {

  $.each( elements, function( key, element ) {
    value = $(element).val().trim();
    if (value != "") {
      return true;
    }
  });

  return false;
}


function clear_errors(context){
  $(context+' .form-group').children('span.text-danger').remove();
  $(context+' .form-group').removeClass('has-error');
}


function validate_email(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function validate_date(date){
  var text = date;
  var comp = text.split('/');
  var d = parseInt(comp[0], 10);
  var m = parseInt(comp[1], 10);
  var y = parseInt(comp[2], 10);
  var date = new Date(y,m-1,d);
  if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
    return true;
  } else {
    return false;
  }
}

function validateMonth(value){
  return (parseInt(value) > 0) && (parseInt(value) < 13)
}

function stringToDate(strDate){
  var comp = strDate.split('/');
  var d = parseInt(comp[0], 10);
  var m = parseInt(comp[1], 10);
  var y = parseInt(comp[2], 10);
  return new Date(y,m,d);
}

function getCurrentDate(){
  strDate = $('#current-date').val()
  if (strDate == undefined) {
    date = new Date()
  } else {
    date = stringToDate(strDate)
  }
  
  return date
}

function validate_phone_number(value) {
    value = value.replace("(","");
    value = value.replace(")", "");
    value = value.replace("-", "");
    value = value.replace(" ", "").trim();
    if (value == '0000000000') {
        return false;
    } else if (value == '00000000000') {
        return false;
    } 
    if (["00", "01", "02", "03", , "04", , "05", , "06", , "07", , "08", "09", "10"].indexOf(value.substring(0, 2)) != -1) {
        return false;
    }
    if (value.length < 10 || value.length > 11) {
        return  false;
    }
    if (["6", "7", "8", "9"].indexOf(value.substring(2, 3)) == -1) {
        return false;
    }
    return true;
}

function validate_cpf(cpf) {
   cpf = cpf.replace(/\./g,'').replace(/\-/g,'');
   var numeros, digitos, soma, i, resultado, digitos_iguais;
      digitos_iguais = 1;
      if (cpf.length < 11)
            return false;
      for (i = 0; i < cpf.length - 1; i++)
            if (cpf.charAt(i) != cpf.charAt(i + 1))
                  {
                  digitos_iguais = 0;
                  break;
                  }
      if (!digitos_iguais)
            {
            numeros = cpf.substring(0,9);
            digitos = cpf.substring(9);
            soma = 0;
            for (i = 10; i > 1; i--)
                  soma += numeros.charAt(10 - i) * i;
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(0))
                  return false;
            numeros = cpf.substring(0,10);
            soma = 0;
            for (i = 11; i > 1; i--)
                  soma += numeros.charAt(11 - i) * i;
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(1))
                  return false;
            return true;
            }
      else
            return false;
}

function validate_cnpj(cnpj) {
 
    cnpj = cnpj.replace(/[^\d]+/g,'');
 
    if(cnpj == '') return false;
     
    if (cnpj.length != 14)
        return false;
 
    // Elimina CNPJs invalidos conhecidos
    if (cnpj == "00000000000000" || 
        cnpj == "11111111111111" || 
        cnpj == "22222222222222" || 
        cnpj == "33333333333333" || 
        cnpj == "44444444444444" || 
        cnpj == "55555555555555" || 
        cnpj == "66666666666666" || 
        cnpj == "77777777777777" || 
        cnpj == "88888888888888" || 
        cnpj == "99999999999999")
        return false;
         
    // Valida DVs
    tamanho = cnpj.length - 2
    numeros = cnpj.substring(0,tamanho);
    digitos = cnpj.substring(tamanho);
    soma = 0;
    pos = tamanho - 7;
    for (i = tamanho; i >= 1; i--) {
      soma += numeros.charAt(tamanho - i) * pos--;
      if (pos < 2)
            pos = 9;
    }
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(0))
        return false;
         
    tamanho = tamanho + 1;
    numeros = cnpj.substring(0,tamanho);
    soma = 0;
    pos = tamanho - 7;
    for (i = tamanho; i >= 1; i--) {
      soma += numeros.charAt(tamanho - i) * pos--;
      if (pos < 2)
            pos = 9;
    }
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(1))
          return false;
           
    return true;
    
}

controls = controls || (function () {
    htmlLoading = '<div id="pleaseWaitDialog" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false"><div class="modal-dialog"><div class="modal-content"><div class="modal-body"><i class="fa fa-circle-o-notch fa-spin"></i>  Aguarde...</div></div></div></div>'
    var pleaseWaitDiv = $(htmlLoading);
    return {
        showPleaseWait: function() {
            pleaseWaitDiv.modal('show');
        },
        hidePleaseWait: function () {
            pleaseWaitDiv.modal('hide');
        },

    };
})();


htmlTemplates = htmlTemplates || (function(){
  htmlLoading = '<div class="row"><div class="col-lg-12" style="margin-top: 30px;">'+
                '<div class="m-loader m-loader--success m-loader--lg">'+
                '</div><br><h5 class="text-center">Carregando</h5></div></div>';
  
  return {
    loading: function(){
      return htmlLoading;
    }
  };

})();


function goToRoot(){
  window.location = "/";
}

/*

Checks the MaxLength of the Textarea
-----------------------------------------------------
@prerequisite:  textBox = textarea dom element
        e = textarea event
                length = Max length of characters
*/
function checkTextAreaMaxLength(textBox, e) { 
    
    var maxLength = parseInt($(textBox).data("length"));
    
  
    if (!checkSpecialKeys(e)) { 
        if (textBox.value.length > maxLength - 1) textBox.value = textBox.value.substring(0, maxLength); 
   } 
  $(".char-count").html(maxLength - textBox.value.length);
    
    return true; 
} 
/*
Checks if the keyCode pressed is inside special chars
-------------------------------------------------------
@prerequisite:  e = e.keyCode object for the key pressed
*/
function checkSpecialKeys(e) { 
    if (e.keyCode != 8 && e.keyCode != 46 && e.keyCode != 37 && e.keyCode != 38 && e.keyCode != 39 && e.keyCode != 40) 
        return false; 
    else 
        return true; 
}