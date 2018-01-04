// nginx redirects /sv -> host:8000 (see README/nginx.conf)
const fastcgiAddress = "/sv";
// 1/nanosecond
const invNs = 1e8;
const speedOfSound = 1500;

const chartContainerPrefix = 'chart';

// Array of canvasjs library objects
let plots = {};

let isFirstLoad = true;

// Needed to stop polling by interval
let intervalHandler = 0;

// Needed to restore size of charts
let defaultChartWidth = 0;
let defaultChartHeight = 0;
let isGeneratorTest = 0;

let chartRows = 0;
let chartCols = 0;

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

    function createChartContainers(rows, cols) {
        for (let j = 0; j < cols; j++) {
            for (let i = 0; i < rows; i++) {
                let containerName = (chartContainerPrefix + i) + j;
                plots[containerName] = {
                    name: containerName,
                    chart: new CanvasJS.Chart(containerName, {
                        zoomEnabled: true,
                        zoomType: "x, y",
                        data: [{
                            type: "line",
                            dataPoints: [{x:0, y:0}]
                        }]
                    })
                };
            }
        }
    }

    function initDefaultChartSize() {
        defaultChartWidth = $(document.getElementById(chartContainerPrefix + '00')).width();
        defaultChartHeight = $(document.getElementById(chartContainerPrefix + '00')).height();
    }

    function toPointObjectCallback(pointArr) {
        return {x:pointArr[0], y:pointArr[1]};
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
        let postData = spacify([isGeneratorTest, d1, d2, d3, d4, sliceBeg, sliceEnd, threshold, frequency, pulseLen, amplitude, sampleRate]);

        $.ajax({
            url: fastcgiAddress,
            type: "POST",
            data: postData,
            success: function(response) {
                response = JSON.parse(response);
                document.getElementById('result2').innerHTML = response.delays;
                chartRows = response.data.length;
                chartCols = 2;

                if (isFirstLoad) {
                    isFirstLoad = false;
                    createChartContainers(chartRows, chartCols);
                    initDefaultChartSize();
                }
                // _______________________
                // | chart00  |  chart01 |
                // | chart10  |  chart11 |
                // | chart20  |  chart21 |
                for (let i = 0; i < response.data.length; i++) {
                    let containerName0 = (chartContainerPrefix + i) + '0';
                    plots[containerName0].chart.options.data = [{
                        type: "line",
                        dataPoints: response.data[i].map(toPointObjectCallback)
                    }];
                    plots[containerName0].chart.render();
                    
                    let containerName1 = (chartContainerPrefix + i) + '1';
                    plots[containerName1].chart.options.data = [{
                        type: "line",
                        dataPoints: response.fourier[i].map(toPointObjectCallback)
                    }];
                    plots[containerName1].chart.render();
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
        toggleGeneratorControls();
        isGeneratorTest = 0;
    });

    function resizeCharts() {
        let props = Object.getOwnPropertyNames(plots);
        for (let i = 0; i < props.length; i++) {
            plots[props[i]].chart.render();
        }
    }

    // Resize chart after dragging of corner.
    // We don't know what exactly chart has been resized,
    // so update everything
    $(".resizeableDiv").mouseup(function() {
        resizeCharts();
    });

    $("#pollPeriod").bind('keyup mouseup', function() {
        clearInterval(intervalHandler);
        updateInterval();
    }); 

    // Hide and show controls panel
    function toggleGeneratorControls() {
        $(document.getElementById("generatorControls")).toggle();
        isGeneratorTest = $("#generatorControls").is(":visible") ? 1 : 0;
    }

    $("#toggleControlsBtn").click(function() {
        toggleGeneratorControls();
    });

    $("#restoreSizeBtn").click(function() {
        for (let i = 0; i < chartRows; i++) {
            for (let j = 0; j < chartCols; j++) {
                document.getElementById((chartContainerPrefix + i) + j).setAttribute("style", 
                    "width:" + defaultChartWidth + 
                    ";height:" + defaultChartHeight + 
                    ";position:relative");
            }
        }
        resizeCharts();
    }); 
});
