
$(document).ready(function() {
  loadValidator();
});

function loadValidator(){
  $('#form-ts').validator({

    }).on('submit', function(e){
       if (e.isDefaultPrevented()) {
          // handle the invalid form...
        } else {
          ajaxStart();
        }
    });
}

function slider(id,value) {

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

    return slider
}
