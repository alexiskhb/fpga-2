const Event = {
    OFF_CLICKED: 0,
    ON_CLICKED:  1
}

$(document).ready(function() {
    $("#on_button").click(function() {
        alert("ON")
    });

    $("#off_button").click(function() {
        alert("OFF")
    });
});
