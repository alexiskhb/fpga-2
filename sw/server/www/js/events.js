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
            data: "",
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

    $("#chartButton").click(function() {
        // $.plot("#chart", data, options);
    });

    function update_contents() {
        var options = [{
            lines: {
                show: true,
                color: "rgba(255, 255, 255, 0.8)"
            },
            points: {
                show: false
            },
            xaxis: {
                tickDecimals: 1,
                tickSize: 5
            },
            colors: ["#0022FF"]
        }, {
            lines: {
                show: true,
                color: "rgba(255, 255, 255, 0.8)"
            },
            points: {
                show: false
            },
            xaxis: {
                tickDecimals: 1,
                tickSize: 5
            },
        }];

        $.ajax({
            url: fastcgiAddress,
            type: "POST",
            success: function(result) {
                result = result.split('|');
                let delays = result[0].split(';');
                document.getElementById('result2').innerHTML = delays;
                result[1] = result[1].split(';')
                result[2] = result[2].split(';')
                for (var i = 0; i < result[1].length; i++) {
                    for (var j = 0; j < 2; j++) {
                        $.plot(("#chart" + i) + j, JSON.parse(result[j + 1][i]), options[j]);
                    }
                }
            }
        });
    }

    function start() {
        setInterval(update_contents, 2000);
    }

    $(window).on("load", function(e) {
        start();
    });
});
