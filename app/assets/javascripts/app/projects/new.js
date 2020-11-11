$(document).ready(function() {

  $('#btn-add-account').click(function(){
    newAcconunt();
  });

  $('#form-client #bt-search').click(function(){
    searchClient();
  });

  $('#form-client #bt-cep').click(function(){
    searchAddress();
  });

  loadValidator();
  
});


function loadValidator(){
  $('#form-project').validator({
      custom: { 
        'begin-date-validator': function($el) { 
          msg = validateBeginDate($el.val())
          if (msg != ""){
            return msg;
          }
        },
        'end-date-validator': function($el) { 
            msg = validateEndDate($el.val())
            if (msg != ""){
              return msg;
            }
         }
      }
    }).on('submit', function(e){
       if (e.isDefaultPrevented()) {
          // handle the invalid form...
        } else {
          ajaxStart();
          $('#form-client .form-control').removeAttr("disabled");
          // everything looks good!
        }
    });
}



function validateBeginDate(value){

  month = value.split('/')[0]
  monthIsValid = validateMonth(value)

  if (monthIsValid == false) {
    return "mês inválido"
  }

  year = value.split('/')[1]
  currentYear = getCurrentDate().getFullYear()
  yearIsValid = ( (parseInt(year) < currentYear) == false )

  if  (yearIsValid == false) {
    return "ano inválido"
  }

  return ""
}


function validateEndDate(value){

  month = value.split('/')[0]
  monthIsValid = validateMonth(value)

  if (monthIsValid == false) {
    return "mês inválido"
  }

  year = value.split('/')[1]
  currentYear = getCurrentDate().getFullYear()
  yearIsValid = ( (currentYear > parseInt(year)) == false )

  if  (yearIsValid == false) {
    return "ano inválido"
  }

  return ""
}


function newAcconunt(){
  $('#modal-new-account').modal('show');
}

function searchClient(){
  cnpj = $('#client-cnpj').val().replace(/\./g,'').replace(/-/g,'').replace(/\//g,'');
  url = '/projects/client-by-cnpj/'+cnpj;
  $.ajax({
    method: "GET",
    url: url,
    data: {}
  }).done(function( data ) {
    loadClientData(data);
  }).fail(function(res) {
    if (res.status == 404) {
      newClient();
    }
  });
}

function searchAddress(){
  cep = $('#client-cep').val().replace(/-/g,'');
  buscaCep(cep,function(data){
    $('#client-street').val(data.logradouro);
    $('#client-complement').val("");
    $('#client-neighborhood').val(data.bairro);
    $('#client-cep').val(data.cep);
    $('#client-street_number').val("");
    $('#client-street_number').focus();
  });
}

function loadClientData(dto){

  $('#client-id').val(dto.id);
  $('#client-name').val(dto.name);
  $('#client-street').val(dto.street);
  $('#client-street_number').val(dto.street_number);
  $('#client-complement').val(dto.complement);
  $('#client-neighborhood').val(dto.neighborhood);
  $('#client-cep').val(dto.cep);
  $('#client-inscricao_estadual').val(dto.inscricao_estadual);

}

function newClient(){
  $('#client-id').val("");
  // $('#client-name').attr('data-required-error','campo obrigatório');
  $('#form-client .form-control:not(#client-cnpj)').val("");
  $('#form-client .form-control').removeAttr("disabled");
  $('#bt-cep').removeAttr("disabled");
  // $('#form-project').validator('update');
  $('#client-name').focus();
}