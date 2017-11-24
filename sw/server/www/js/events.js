const fastcgiAddress = "/sv";
const speed_of_sound = 1500;
const inv_ns = 1e8;

function to_byte_str_32(num) {
    arr = new ArrayBuffer(4);
    view = new DataView(arr);
    view.setUint32(0, num, false); // byteOffset = 0; litteEndian = false
    return arr;
}

$(document).ready(function() {
    $("#set_mask_button").click(function() {
        let num = parseInt($('#mask_edit').val())
        alert(num)
        $.ajax({
            url: fastcgiAddress,
            type: "POST",
            data: "adasdasd",
            // data: to_byte_str_32(num),
            success: function (data) {
                document.getElementById('result2').innerHTML = data;
            }
        });
    });

    $("#ping_button").click(function() {
        let a1 = document.getElementById('a1_coord').value.split(';');
        let a2 = document.getElementById('a2_coord').value.split(';');
        let a3 = document.getElementById('a3_coord').value.split(';');
        let a4 = document.getElementById('a4_coord').value.split(';');
        let pc = document.getElementById('pinger_coord').value.split(';');

        let d1 = Math.sqrt((pc[0] - a1[0])**2 + (pc[1] - a1[1])**2 + (pc[2] - a1[2])**2);
        let d2 = Math.sqrt((pc[0] - a2[0])**2 + (pc[1] - a2[1])**2 + (pc[2] - a2[2])**2);
        let d3 = Math.sqrt((pc[0] - a3[0])**2 + (pc[1] - a3[1])**2 + (pc[2] - a3[2])**2);
        let d4 = Math.sqrt((pc[0] - a4[0])**2 + (pc[1] - a4[1])**2 + (pc[2] - a4[2])**2);

        let d_min = Math.min(d1, d2, d3, d4);

        let l1 = Math.floor((d1 - d_min)/speed_of_sound*inv_ns);
        let l2 = Math.floor((d2 - d_min)/speed_of_sound*inv_ns);
        let l3 = Math.floor((d3 - d_min)/speed_of_sound*inv_ns);
        let l4 = Math.floor((d4 - d_min)/speed_of_sound*inv_ns);

        $.ajax({
            url: fastcgiAddress,
            type: "POST",
            data: {
            "l1" : l1, 
            "l2" : l2, 
            "l3" : l3, 
            "l4" : l4
        },
            success: function (data) {}
        });
    });

    function update_contents() {
        // $.ajax({
        //     url: fastcgiAddress,
        //     type: "GET",
        //     success: function(result) {
        //         document.getElementById('result').innerHTML = result;
        //     }
        // }); 
    }

    function start() {
        setInterval(update_contents, 1000);
    }

    $(window).load(function(){
        start();
    });
});


