var socket = io();
socket.emit("message", "hi");
socket.on("visitor enters", function(msg) {
    console.log('current number of visitors: ' + msg);
    $("#visitors").text(`current visitors: ${msg}`);
});
