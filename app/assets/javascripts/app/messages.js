function feedbackApproval(approval){

    if (approval) {
        type = 'success';
        message = 'Lançamento aprovado'
    } else {
       type = 'error';
        message = 'Lançamento reprovado' 
    }


    swal.fire({
        position: 'center',
        type: type,
        title: message,
        showConfirmButton: false,
        timer: 1000
    });
}


function feedbackUpdateTS(type,message){
    swal.fire({
        position: 'center',
        type: type,
        title: message,
        showConfirmButton: true
    });   
}