var projectListIsLoading = false;

function slider(id,value,status) {
    // init slider
    if ((status == 'approved') || (status == 'canceled')) {
        return false
    }

    var slider = document.getElementById('nouislider-'+id);

    noUiSlider.create(slider, {
        start: [ value ],
        connect: [true, false],
        step: 5,
        range: {
            'min': [ 0 ],
            'max': [ 100 ]
        },
        format: wNumb({
            decimals: 0,
            thousand: '.',
            postfix: ' %',
        })
    });

    // init slider input
    var sliderInput = document.getElementById('value-'+id);

    slider.noUiSlider.on('update', function( values, handle ) {
        sliderInput.value = values[handle];
    });

    sliderInput.addEventListener('change', function(){
        slider.noUiSlider.set(this.value);
    });

    if (status == 'waiting-approval') {
        slider.setAttribute('disabled', true);
    }

    return slider
}


jQuery(document).ready(function() {
    loadSearch();
    loadDashoard();
    loadImagesProfile();
});

function loadSearch(){

    $('#search').on('input',function(){
        if ( (this.value.length > 2) && (projectListIsLoading == false) ) {
          searchProject();
        } else {
            $('#search-results').hide();
        }
        
    });

}


function searchProject(){

  // showLoading('#search-results','carregando...');

  $('#loading-results').show();

  value = $('#search').val();
  projectListIsLoading = true;
  url = '/projects.json?search[name]='+value

  $.get(url,function(data){
    template = `<a href="javascript:addProject(#ID#)" class="kt-notification__item">
            <div class="kt-notification__item-details">
              <div class="kt-notification__item-title">
                <h5>#NAME#</h5>
              </div>
              <div class="kt-notification__item-time">
                #CC#
              </div>
            </div>
          </a>`;

    $('#search-results .list').html("");

    for (var i = data.length - 1; i >= 0; i--) {
        dto = data[i];
        html = template.replace(/#NAME#/,dto.name).replace(/#ID#/,dto.id).replace(/#CC/,dto.cost_center);
       $('#search-results .list').append(html);
    }
    
    $('#search-results').show();
  }).done(function() {
     projectListIsLoading = false;
     $('#loading-results').hide();
  })
  .fail(function() {
     projectListIsLoading = false;
     $('#loading-results').hide();
  })
  .always(function() {
     projectListIsLoading = false;
     $('#loading-results').hide();
  });


}

function loadDashoard(){
  
  var carousel1 = $('#total-projects .owl-carousel');
  
        carousel1.owlCarousel({
            rtl: KTUtil.isRTL(),
            center: true,
            loop: false,
            items: 2
        });
}

function addProject(id){
    showLoading('body','Aguarde');
    clientApi.getScript('/user-time-sheet/'+id,function(){
        stopLoading();
        $('#search').val("");
        $('#search-results .list').html("");
    });
}

function removeProject(id){
    showLoading('body','Aguarde');
    url = '/user/projects/'+id+'/remove';
    clientApi.put(url,{},function(){
        stopLoading();
        $('#project-'+id).fadeOut('fast', function(){
            $('#project-'+id).remove();
        });
    });
}

function approve(id){
    showLoading('body','Aguarde');
    url = '/approve_time_sheets/'+id+'.json';
    clientApi.put(url,{approve: 'ok'},function(data){
        stopLoading();
        $('#waiting-approval #ts-'+id).fadeOut('fast', function(){
            feedbackApproval(true);
            $('#waiting-approval #ts-'+id).remove();
        });
    });
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
        $('#waiting-approval #ts-'+id).fadeOut('fast', function(){
            feedbackApproval(false);
            $('#waiting-approval #ts-'+id).remove();
        });
    });
}

function cancel(id,project_id){

    swal.fire({
        title: 'Cancelar',
        text: "Você deseja cancelar esse lançamento?",
        type: 'question',
        showCancelButton: true,
        cancelButtonText:'Não',
        confirmButtonText: 'Sim'
    }).then(function(result) {
        if (result.value) {
            showLoading('body','Aguarde');
            url = '/cancel_time_sheets/'+id+'.json';
            clientApi.put(url,{approve: 'no'},function(data){
                stopLoading();
                $('#project-'+project_id).fadeOut('fast', function(){
                    showSuccessConfirmation("Lançamento cancelado");
                    $('#project-'+project_id).remove();
                });
            });

        }
    });
}



