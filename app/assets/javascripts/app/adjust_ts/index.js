
$(document).ready(function() {
  loadImagesProfile();

  $('.btn-disapprove').click(function(){
    id = $(this).data('id');
    disapprove_with_confirm(id);
  });

});

function filter(date){
  
}

function disapprove_with_confirm(id){
    swal.fire({
        title: 'Deseja recusar esse lançamento?',
        text: "",
        type: 'question',
        showCancelButton: true,
        confirmButtonText: 'Sim',
        cancelButtonText: 'Cancelar'
    }).then(function(result) {
        if (result.value) {
           disapprove(id);
        }
    });
}

function disapprove(id){
    showLoading('body','Aguarde');
    url = '/approve_time_sheets/'+id+'.json';
    clientApi.put(url,{approve: 'no'},function(data){
        stopLoading();
        $('#ts-'+id).fadeOut('fast', function(){
            feedbackApproval(false);
            $('#waiting-approval #ts-'+id).remove();
        });
    });
}
