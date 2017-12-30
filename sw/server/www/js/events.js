const fastcgiAddress = "/sv";
const speed_of_sound = 1500;
const inv_ns = 1e8;

function to_byte_str_32(num) {
    arr = new ArrayBuffer(4);
    view = new DataView(arr);
    view.setUint32(0, num, false);
    return arr;
}

let plots = [];
let intervalHandler = 0;

$(document).ready(function() {
    $("#set_mask_button").click(function() {
        let num = parseInt($('#mask_edit').val());
        alert(num);
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
        update_contents();
    });

    function spacify(ary) {
        result = "";
        for (var i = 0; i < ary.length; i++) {
            result += ary[i] + " ";
        }
        return result;
    }

    function update_contents() {
        let a1 = document.getElementById('a1_coord').value.split(';');
        let a2 = document.getElementById('a2_coord').value.split(';');
        let a3 = document.getElementById('a3_coord').value.split(';');
        let a4 = document.getElementById('a4_coord').value.split(';');
        let pc = ("0;0;0").split(';');

        let d1 = Math.sqrt((pc[0] - a1[0])**2 + (pc[1] - a1[1])**2 + (pc[2] - a1[2])**2);
        let d2 = Math.sqrt((pc[0] - a2[0])**2 + (pc[1] - a2[1])**2 + (pc[2] - a2[2])**2);
        let d3 = Math.sqrt((pc[0] - a3[0])**2 + (pc[1] - a3[1])**2 + (pc[2] - a3[2])**2);
        let d4 = Math.sqrt((pc[0] - a4[0])**2 + (pc[1] - a4[1])**2 + (pc[2] - a4[2])**2);

        let d_min = Math.min(d1, d2, d3, d4);

        let l1 = Math.floor((d1 - d_min)/speed_of_sound*inv_ns);
        let l2 = Math.floor((d2 - d_min)/speed_of_sound*inv_ns);
        let l3 = Math.floor((d3 - d_min)/speed_of_sound*inv_ns);
        let l4 = Math.floor((d4 - d_min)/speed_of_sound*inv_ns);

        let slice = document.getElementById('slice').value.split(';');
        let slice_beg = slice[0];
        let slice_end = slice[1];
        let threshold = document.getElementById('threshold').value;
        let frequency = document.getElementById('frequency').value;
        let pulse_len = document.getElementById('pulse_len').value;
        let amplitude = document.getElementById('amplitude').value;
        let sample_rate = document.getElementById('sample_rate').value;
        let post_data = spacify([d1, d2, d3, d4, slice_beg, slice_end, threshold, frequency, pulse_len, amplitude, sample_rate]);

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
            },
        }];

        $.ajax({
            url: fastcgiAddress,
            type: "POST",
            data: post_data,
            success: function(result) {
                result = result.split('|');
                let delays = result[0].split(';');
                document.getElementById('result2').innerHTML = delays;
                result[1] = result[1].split(';');
                result[2] = result[2].split(';');
                chartRows = result[1].length;
                chartCols = 2;
                for (var i = 0; i < chartRows; i++) {
                    for (var j = 0; j < chartCols; j++) {
                        if (plots.length < chartCols*chartRows) {
                            plots.push(0);
                        }
                        let dt = JSON.parse(result[j + 1][i]);
                        plots[i*chartCols + j] = $.plot(("#chart" + i) + j, dt, options[j]);
                    }
                }
            }
        });
    }

    function start() {
        let value = $("#poll_period").val();
        if (0 < value && value < 1000) {
            intervalHandler = setInterval(update_contents, value*1000); 
        }
    }

    $(window).on("load", function(e) {
        start();
    });

    $(window).resize(function() {
        
    });

    $(".resizeableDiv").mouseup(function() {
        for (var i = 0; i < plots.length; i++) {
            plots[i].resize();
            plots[i].setupGrid();
            plots[i].draw();
        }
    });

    $("#poll_period").bind('keyup mouseup', function () {
        let value = $("#poll_period").val();
        clearInterval(intervalHandler);
        if (0 < value && value < 1000) {
            intervalHandler = setInterval(update_contents, value*1000); 
        }
    }); 

    $("#toggleControls").click(function(){
        $(document.getElementById("generatorControls")).toggle();
    }); 
});
