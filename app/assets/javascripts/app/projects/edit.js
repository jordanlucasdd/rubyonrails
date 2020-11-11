$(document).ready(function() {

  $('#btn-add-account').click(function(){
    newAcconunt();
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