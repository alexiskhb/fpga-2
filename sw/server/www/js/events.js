$(document).ready(function() {
    const fastcgiAddress = "cgi-bin";
    // 1/nanosecond
    const invNs = 1e8;
    const speedOfSound = 1500;

    let requetstId = 0;

    const EventType = {
        SETTINGS_GET:     0, 
        SETTINGS_SET:     1, 
        STOP_DMA:         2, 
        START_DMA:        3, 
        PENDING:          4, 
        START_NAVIG_TEST: 5, 
        DRAW_DATA:        6
    }

    // __________________________
    // | chart00 | chart01 | ...
    // | chart10 | chart11 | ...
    // | chart20 | chart21 | ...
    // |   ...   |   ...   | ...
    const chartContainerPrefix = 'chart';

    // use host?<transposedGetParameter>=1
    // to see transposed table:
    // ___________________________________
    // | chart00 | chart10 | chart20 | ...
    // | chart01 | chart11 | chart21 | ...
    // |   ...   |   ...   |   ...   | ...
    const transposedGetParameter = 'transposed';

    // Array of canvasjs library objects
    let plots = {};

    let isFirstLoad = true;

    // Needed to stop polling by interval
    let intervalHandler = 0;

    // Needed to restore size of charts
    let defaultChartWidth = 0;
    let defaultChartHeight = 0;

    let chartRows = 0;
    let chartCols = 0;

    let modes = {};

    function registerMode(properties) {
        let name = properties.name;
        let value = $("select[id=modeSelector] option").length;
        let option = $('<option>').attr('value', value).html(name);
        $('#modeSelector').append(option);
        modes[value] = properties;
    }

    function inputChanged() {
        $("#setButton").html("Set*");
    }

    function applyMode(modeValue) {
        $('#simulatorControls').empty();
        properties = modes[modeValue];
        let name = properties.name;
        properties = properties.props;
        for (var i = 0; i < properties.length; i++) {
            let row = $('<tr>');
            row.append($('<td>').html(properties[i].caption));
            let td = $('<td>');
            let input = $('<' + properties[i].tag + '>').attr("id", properties[i].id);
            for (let j = 0; j < properties[i].attrs.length; j++) {
                if (properties[i].attrs[j][0] == "value" && $.cookie(properties[i].id)) {
                    input.attr(properties[i].attrs[j][0], $.cookie(properties[i].id));
                } else {
                    input.attr(properties[i].attrs[j][0], properties[i].attrs[j][1]);
                }
            }
            input.on('change', inputChanged);
            input.keypress(inputChanged);
            td.append(input);
            row.append(td);
            $('#simulatorControls').append(row);
        }
    }

    $('#modeSelector').on('change', function(event) {
        applyMode($("select#modeSelector").val());
        $("#setButton").click();
    });

    function semicolonToAry(text) {
        return text.split(';').map(Number);
    }

    $("#pingButton").click(function() {
        $("#pingButton").html("Ping*");
        updateContents();
    });

    function postStartStopEvent(eventType) {
        let postData = {
            mode: Number($("select#modeSelector").val()),
            eventType: eventType
        }
        
        postData = JSON.stringify(postData);
        $.ajax({
            url: fastcgiAddress,
            type: "POST",
            data: postData,
            success: function(response) {

            }
        });
    }

    $("#startDma").click(function() {
        postStartStopEvent(EventType.START_DMA);
    });

    $("#stopDma").click(function() {
        postStartStopEvent(EventType.STOP_DMA);
    });

    function findGetParameter(parameterName) {
        var result = 0,
        tmp = [];
        var items = location.search.substr(1).split("&");
        for (var index = 0; index < items.length; index++) {
            tmp = items[index].split("=");
            if (tmp[0] === parameterName) {
                result = decodeURIComponent(tmp[1]);
            }
        }
        return result;
    }

    function createHtmlTable(rows, cols, transposed) {
        let actualRows = transposed ? cols : rows;
        let actualCols = transposed ? rows : cols;
        for (let i = 0; i < actualRows; i++) {
            let row = $('<tr>');
            for (let j = 0; j < actualCols; j++) {
                let ai = transposed ? j : i;
                let aj = transposed ? i : j;
                let containerName = (chartContainerPrefix + ai) + aj;
                let td = $('<td>').attr('class', 'resizabletd').append(
                    $('<div>').attr('class', 'resizableDiv').attr('id', containerName)
                );
                row.append(td);
            }
            $('#chartsTable').append(row);
        }
    }

    function createChartContainers(rows, cols) {
        createHtmlTable(rows, cols, findGetParameter(transposedGetParameter) != 0);
        for (let i = 0; i < rows; i++) {
            for (let j = 0; j < cols; j++) {
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
        let mode = modes[$("select#modeSelector").val()];
        let postData = {
            mode: Number($("select#modeSelector").val()),
            slice: semicolonToAry(document.getElementById('slice').value),
            requetstId: ++requetstId,
            eventType: EventType.PENDING
        };
        if (modes[$("select#modeSelector").val()].name == "serv_sim") {
            for (var i = 0; i < mode.props.length; i++) {
                let value = document.getElementById(mode.props[i].id).value;
                postData[mode.props[i].id] = mode.props[i].transform(value);
            }
        }
        
        postData = JSON.stringify(postData);
        $.ajax({
            url: fastcgiAddress,
            type: "POST",
            data: postData,
            success: function(response) {
                $("#pingButton").html("Ping");
                response = JSON.parse(response);
                if (Object.getOwnPropertyNames(response).length == 1) {
                    return;
                }
                document.getElementById('calculatedDelays').innerHTML = response.delays;
                chartRows = response.data.length;
                chartCols = 2;

                if (isFirstLoad) {
                    isFirstLoad = false;
                    createChartContainers(chartRows, chartCols);
                    initDefaultChartSize();
                }

                for (let i = 0; i < response.data.length; i++) {
                    let containerName0 = (chartContainerPrefix + i) + '0';
                    plots[containerName0].chart.options.data = [{
                        type: "line",
                        dataPoints: response.data[i].map(toPointObjectCallback)
                    }];
                    if ($('#showHilbert').is(":checked")) {
                        plots[containerName0].chart.options.data.push({
                            type: "line",
                            dataPoints: response.hilbert[i].map(toPointObjectCallback)
                        });
                    }
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

    function resizeCharts() {
        let props = Object.getOwnPropertyNames(plots);
        for (let i = 0; i < props.length; i++) {
            plots[props[i]].chart.render();
        }
    }

    // Resize chart after dragging of corner.
    // We don't know what exactly chart has been resized,
    // so update everything
    $("#chartsTable").mouseup(function() {
        resizeCharts();
    });

    $("#pollPeriod").bind('keyup mouseup', function() {
        clearInterval(intervalHandler);
        updateInterval();
    }); 

    $("#setButton").click(function() {
        $("#setButton").html("Set**");
        let mode = modes[$("select#modeSelector").val()];
        let postData = {
            mode: Number($("select#modeSelector").val()),
            slice: semicolonToAry(document.getElementById('slice').value),
            requetstId: ++requetstId,
            eventType: EventType.SETTINGS_SET
        };
        for (var i = 0; i < mode.props.length; i++) {
            postData[mode.props[i].id] = mode.props[i].transform(document.getElementById(mode.props[i].id).value);
            $.cookie(mode.props[i].id, document.getElementById(mode.props[i].id).value, {
                expires: 30
            });
        }
        postData = JSON.stringify(postData);
        $.ajax({
            url: fastcgiAddress,
            type: "POST",
            data: postData,
            success: function(response) {
                $("#setButton").html("Set");
            }
        });
    });

    $("#getButton").click(function() {
        $("#getButton").html("Get*");
        let mode = modes[$("select#modeSelector").val()];
        let postData = {
            mode: Number($("select#modeSelector").val()),
            eventType: EventType.SETTINGS_GET
        };
        postData = JSON.stringify(postData);
        $.ajax({
            url: fastcgiAddress,
            type: "POST",
            data: postData,
            success: function(response) {
                response = JSON.parse(response);
                $('#frequency').val(response.frequency);
                $('#fftThreshold').val(response.fftThreshold);
                $("#getButton").html("Get");
            }
        });
    });

    // Hide and show controls panel
    function toggleSimulatorControls() {
        $(document.getElementById("simulatorControlsDiv")).toggle();
    }

    $("#toggleSimulatorControls").click(function() {
        toggleSimulatorControls();
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

    function init() {
        updateInterval();
        $(document.getElementById("simulatorControlsDiv")).hide();
        registerMode({
            name: "real_mode",
            props: [
                {
                    tag: "input",
                    caption: "FFT threshold (comp)",
                    id: "fftThreshold",
                    attrs: [["type", "number"], ["value", "0"]],
                    transform: Number
                },
                {
                    tag: "input",
                    caption: "Hilbert threshold (rx)",
                    id: "hilbertThreshold",
                    attrs: [["type", "number"], ["value", "0"], ["step", "0.01"]],
                    transform: Number
                },
                {
                    tag: "input",
                    caption: "Frequency (kHz)",
                    id: "frequency",
                    attrs: [["type", "number"], ["value", "25"], ["min", "0"], ["step", "1"]],
                    transform: Number
                }
            ]
        });
        applyMode($("select#modeSelector").val());
    }
    
    init();
});
