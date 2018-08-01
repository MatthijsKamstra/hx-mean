// Generated by Haxe 3.4.7
(function () { "use strict";
var MainClient = function() {
	if(window.document.getElementById("visitors") == null) {
		var div = window.document.createElement("div");
		div.id = "visitors";
		div.className = "container";
		window.document.body.appendChild(div);
	}
	var socket = io();
	socket.emit("message","hi");
	socket.emit("send",{ message : "text", username : "_inputName.value"});
	socket.on("visitor enters",function(msg) {
		window.console.log("current number of visitors (enters): " + msg);
		$("#visitors").text("current visitors: " + msg);
	});
	socket.on("visitor exits",function(msg1) {
		window.console.log("current number of visitors (exits): " + msg1);
		$("#visitors").text("current visitors: " + msg1);
	});
	socket.on("message",function(data) {
		if(data != null) {
			console.log(data);
		}
	});
};
MainClient.main = function() {
	var app = new MainClient();
};
MainClient.main();
})();
