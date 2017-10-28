$(document).ready(function() {
    // fetch('http://localhost/sv').then(function(response) {
    //     response.text().then(function(text) {
    //         document.getElementById('result').innerHTML = text;
    //     });
    // });

    $("#set_mask_button").click(function() {
        $.ajax({
            url: "http://localhost/sv",
            type: "GET",
            // data: $("#set_mask_button"),
            success: function (data) {
                document.getElementById('result2').innerHTML = data;
            }
        });
    });

    var interval = 0;
    function start() {
        setTimeout( function() {
            update_contents();
            interval = 1;
            setInterval( function() {
                update_contents();
            }, interval*1000);
        }, interval*1000);    
    }

    function update_contents() {
        $.ajax({
            url: "http://localhost/sv",
            type: "GET",
            success: function(result) {
                // $('.time').html(result);
                document.getElementById('result').innerHTML = result;
            }
        }); 
    }

    $(window).load(function(){
        // var time = new Date();
        // interval = 1 - time.getSeconds();
        // if(interval==1)
        //     interval    =   0;
        start();
    });
});


