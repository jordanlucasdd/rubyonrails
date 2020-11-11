function buscaCep(value,success) {


        //Nova variável "cep" somente com dígitos.
        var cep = value.replace(/\D/g, '');

        //Verifica se campo cep possui valor informado.
        if (cep != "") {

            //Expressão regular para validar o CEP.
            var validacep = /^[0-9]{8}$/;

            //Valida o formato do CEP.
            if(validacep.test(cep)) {


                //Consulta o webservice viacep.com.br/
                $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {
                    controls.hidePleaseWait();
                    if (!("erro" in dados)) {
                        //Atualiza os campos com os valores da consulta.
                        success(dados);
                        
                    } //end if.
                    else {
                        alert("CEP não encontrado.");
                    }
                });
            } //end if.
            else {
                alert("Formato de CEP inválido.");
            }
        } //end if.
        else {
            //cep sem valor, limpa formulário.
        }
}