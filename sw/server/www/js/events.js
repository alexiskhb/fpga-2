// nginx redirects /sv -> host:8000 (see README/nginx.conf)
const fastcgiAddress = "/sv";
// 1/nanosecond
const invNs = 1e8;
const speedOfSound = 1500;

// Array of flot librar objects
let plots = [];

// Needed to stop polling by interval
let intervalHandler = 0;

// Needed to restore size of charts
let defaultChartWidth = 0;
let defaultChartHeight = 0;
let is_generator_test = 0;

$(document).ready(function() {
    $("#pingButton").click(function() {
        updateContents();
    });

    function spacify(ary) {
        result = "";
        for (let i = 0; i < ary.length; i++) {
            result += ary[i] + " ";
        }
        return result;
    }


    function updateContents() {
        // Read coordinates of receivers
        let a1 = document.getElementById('a1Coord').value.split(';');
        let a2 = document.getElementById('a2Coord').value.split(';');
        let a3 = document.getElementById('a3Coord').value.split(';');
        let a4 = document.getElementById('a4Coord').value.split(';');

        let pc = ("0;0;0").split(';');
        let d1 = Math.sqrt((pc[0] - a1[0])**2 + (pc[1] - a1[1])**2 + (pc[2] - a1[2])**2);
        let d2 = Math.sqrt((pc[0] - a2[0])**2 + (pc[1] - a2[1])**2 + (pc[2] - a2[2])**2);
        let d3 = Math.sqrt((pc[0] - a3[0])**2 + (pc[1] - a3[1])**2 + (pc[2] - a3[2])**2);
        let d4 = Math.sqrt((pc[0] - a4[0])**2 + (pc[1] - a4[1])**2 + (pc[2] - a4[2])**2);
        // let dMin = Math.min(d1, d2, d3, d4);
        // let l1 = Math.floor((d1 - dMin)/speedOfSound*invNs);

        let slice = document.getElementById('slice').value.split(';');
        let sliceBeg = slice[0];
        let sliceEnd = slice[1];
        let threshold = document.getElementById('threshold').value;
        let frequency = document.getElementById('frequency').value;
        let pulseLen = document.getElementById('pulseLen').value;
        let amplitude = document.getElementById('amplitude').value;
        let sampleRate = document.getElementById('sampleRate').value; 

        // Post-query to server is space separated array of parameters for signal generator
        let postData = spacify([is_generator_test, d1, d2, d3, d4, sliceBeg, sliceEnd, threshold, frequency, pulseLen, amplitude, sampleRate]);

        let options = [{
                xaxis: {
                    tickDecimals: 1,
                },
                colors: ["#0022FF", "#00FF22"]
            }, {
                xaxis: {
                    tickDecimals: 1,
                }
            }];
        $.ajax({
            url: fastcgiAddress,
            type: "POST",
            data: postData,
            success: function(result) {
                result = JSON.parse(result);
                document.getElementById('result2').innerHTML = result.delays;
                chartRows = result.data.length;
                chartCols = 2;
                // Save references to plots to be able
                // to resize them later
                while (plots.length < result.data.length + result.fourier.length) {
                    plots.push(0);
                }
                // _______________________
                // | chart00  |  chart01 |
                // | chart10  |  chart11 |
                // | chart20  |  chart21 |
                for (let i = 0; i < result.data.length; i++) {
                    plots[i] = $.plot(("#chart" + i) + 0, [result.data[i]], options[0]);
                }
                for (let i = 0; i < result.fourier.length; i++) {
                    plots[result.data.length + i] = $.plot(("#chart" + i) + 1, [result.fourier[i]], options[1]);
                }
            }
        });
    }

    function updateInterval() {
        let value = $("#pollPeriod").val();
        if (0 < value && value < 1000) {
            intervalHandler = setInterval(updateContents, value*1000); 
        }
    }

    // Executes when the page loads
    $(window).on("load", function(e) {
        updateInterval();
        defaultChartWidth = $(document.getElementById('chart00')).width();
        defaultChartHeight = $(document.getElementById('chart00')).height();
        toggleGeneratorControls();
        is_generator_test = 0;
    });

    function resizeCharts() {
        for (let i = 0; i < plots.length; i++) {
            plots[i].resize();
            plots[i].setupGrid();
            plots[i].draw();
        }
    }

    // Resize chart after dragging of corner.
    // We don't know what exactly chart has been resized,
    // so update everything
    $(".resizeableDiv").mouseup(function() {
        resizeCharts();
    });

    $("#pollPeriod").bind('keyup mouseup', function () {
        clearInterval(intervalHandler);
        updateInterval();
    }); 

    // Hide and show controls panel
    function toggleGeneratorControls() {
        $(document.getElementById("generatorControls")).toggle();
        is_generator_test = 1 - is_generator_test;
    }

    $("#toggleControlsBtn").click(function() {
        toggleGeneratorControls();
    });

    $("#restoreSizeBtn").click(function() {
        for (let i = 0; i < chartRows; i++) {
            for (let j = 0; j < chartCols; j++) {
                document.getElementById(('chart' + i) + j).setAttribute("style", 
                    "width:" + defaultChartWidth + 
                    ";height:" + defaultChartHeight + 
                    ";position:relative");
            }
        }
        resizeCharts();
    }); 
});
