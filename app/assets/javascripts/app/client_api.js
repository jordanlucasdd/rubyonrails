var clientApi;

clientApi = clientApi || (function(){
  
  return {
    getScript: function(path,success){
      $.ajax({url: path,dataType: 'script',method: 'GET',success: success});
    },

    postScript: function(path,success) {
      $.ajax({url: path, dataType: 'script', method: 'POST', success: success});
    },

    putScript: function(path,success) {
      $.ajax({url: path, dataType: 'script', method: 'PUT', success: success});
    },

    get: function(path,data,whenDone){

      $.ajax({
        method: "GET",
        url: path,
        data: data
      }).done(function( data ) {
        whenDone(data);
      });

    },

    put: function(path,data,whenDone){

      $.ajax({
         url: path,
         type: 'PUT',
         data: data,
         success: function(response) {
           whenDone(response);
         }
      });

    }

  }

})();

 