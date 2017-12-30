const fastcgiAddress = "/sv";
const speedOfSound = 1500;
const invNs = 1e8;

let plots = [];
let intervalHandler = 0;
let defaultChartWidth = 0;
let defaultChartHeight = 0;
let oldChartHtml = 0;

$(document).ready(function() {
    $("#setMaskButton").click(function() {
        let num = parseInt($('#maskEdit').val());
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

    $("#pingButton").click(function() {
        updateContents();
    });

    function spacify(ary) {
        result = "";
        for (var i = 0; i < ary.length; i++) {
            result += ary[i] + " ";
        }
        return result;
    }

    function updateContents() {
        let a1 = document.getElementById('a1Coord').value.split(';');
        let a2 = document.getElementById('a2Coord').value.split(';');
        let a3 = document.getElementById('a3Coord').value.split(';');
        let a4 = document.getElementById('a4Coord').value.split(';');
        let pc = ("0;0;0").split(';');

        let d1 = Math.sqrt((pc[0] - a1[0])**2 + (pc[1] - a1[1])**2 + (pc[2] - a1[2])**2);
        let d2 = Math.sqrt((pc[0] - a2[0])**2 + (pc[1] - a2[1])**2 + (pc[2] - a2[2])**2);
        let d3 = Math.sqrt((pc[0] - a3[0])**2 + (pc[1] - a3[1])**2 + (pc[2] - a3[2])**2);
        let d4 = Math.sqrt((pc[0] - a4[0])**2 + (pc[1] - a4[1])**2 + (pc[2] - a4[2])**2);

        let dMin = Math.min(d1, d2, d3, d4);

        let l1 = Math.floor((d1 - dMin)/speedOfSound*invNs);
        let l2 = Math.floor((d2 - dMin)/speedOfSound*invNs);
        let l3 = Math.floor((d3 - dMin)/speedOfSound*invNs);
        let l4 = Math.floor((d4 - dMin)/speedOfSound*invNs);

        let slice = document.getElementById('slice').value.split(';');
        let sliceBeg = slice[0];
        let sliceEnd = slice[1];
        let threshold = document.getElementById('threshold').value;
        let frequency = document.getElementById('frequency').value;
        let pulseLen = document.getElementById('pulseLen').value;
        let amplitude = document.getElementById('amplitude').value;
        let sampleRate = document.getElementById('sampleRate').value;
        let postData = spacify([d1, d2, d3, d4, sliceBeg, sliceEnd, threshold, frequency, pulseLen, amplitude, sampleRate]);

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
            data: postData,
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
        let value = $("#pollPeriod").val();
        if (0 < value && value < 1000) {
            intervalHandler = setInterval(updateContents, value*1000); 
        }
    }

    $(window).on("load", function(e) {
        start();
        defaultChartWidth = $(document.getElementById('chart00')).width();
        defaultChartHeight = $(document.getElementById('chart00')).height();
        toggleGeneratorControls();
    });

    function resizeCharts() {
        for (var i = 0; i < plots.length; i++) {
            plots[i].resize();
            plots[i].setupGrid();
            plots[i].draw();
        }
    }

    $(".resizeableDiv").mouseup(function() {
        resizeCharts();
    });

    $("#pollPeriod").bind('keyup mouseup', function () {
        let value = $("#pollPeriod").val();
        clearInterval(intervalHandler);
        if (0 < value && value < 1000) {
            intervalHandler = setInterval(updateContents, value*1000); 
        }
    }); 

    function toggleGeneratorControls() {
        $(document.getElementById("generatorControls")).toggle();
    }

    $("#toggleControlsBtn").click(function() {
        toggleGeneratorControls();
    });

    $("#restoreSizeBtn").click(function() {
        for (var i = 0; i < chartRows; i++) {
            for (var j = 0; j < chartCols; j++) {
                document.getElementById(('chart' + i) + j).setAttribute("style", 
                    "width:" + defaultChartWidth + 
                    ";height:" + defaultChartHeight + 
                    ";position:relative");
                // document.getElementById(('chart' + i) + j).setAttribute("class", "resizeableDiv");
            }
        }
        resizeCharts();
    }); 
});
