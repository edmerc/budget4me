
<script src="./node_modules/jquery/dist/jquery.min.js"></script>
<script>
    function getAccounts() {
      let request = $.ajax({
            url: "cfc/bdgAccounts.cfc?method=getJson_Accounts",
            method: "POST",
            dataType: "json"
        });
        request.done(function( msg ) {
        obj = JSON.parse(request.responseText);
            writeRows(obj);
        });
        request.fail(function( jqXHR, textStatus ) {
        alert( "Request failed: " + textStatus );
        });  
    }
    function writeRows(obj){
        let objData = obj.DATA;
        $.each(objData, function(key,value) {
            console.log(value[0]);
            console.log(value[1]);
            console.log(value[2]);
            console.log(value[3]);
            console.log(value[4]);
            console.log(value[5]);
        });
    }
   
   getAccounts();

</script>