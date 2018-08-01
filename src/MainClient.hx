package;

import js.Browser;
import js.Browser.*;
import js.html.*;


import js.jquery.JQuery;

class MainClient {

	public function new () {

		var div = document.createDivElement();
		div.id = 'visitors';
		div.className = "container";
		document.body.appendChild(div);

		// var socket = untyped io();
		// var socket = js.browser.SocketIo.connect();
		var socket = js.browser.SocketIo.io();
		socket.emit("message", "hi");
		socket.on("visitor enters", function(msg) {
			console.log('current number of visitors (enters): ' + msg);
			new JQuery("#visitors").text('current visitors: ${msg}');
		});
		socket.on("visitor exits", function(msg) {
			console.log('current number of visitors (exits): ' + msg);
			new JQuery("#visitors").text('current visitors: ${msg}');
		});
	}

	static public function main () {
		var app = new MainClient ();
	}
}