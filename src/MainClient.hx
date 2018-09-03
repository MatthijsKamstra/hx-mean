package;

import js.Browser;
import js.Browser.*;
import js.html.*;


import js.jquery.JQuery;

import externs.js.node.socketio.Client;

using StringTools;

class MainClient {

	public function new () {
		initJQuery();
		initVanillaJs();
		initPages();
		initSockets();
	}

	function initSockets(){

		// check if the id is already in the page, otherwise generate
		// but hide it them... it might change the layout
		if(document.getElementById('visitors') == null ){
			var div = document.createDivElement();
			div.id = 'visitors';
			div.className = "container";
			div.setAttribute('style', 'display:none;');
			document.body.appendChild(div);
		}

		// var socket = untyped io();
		// var socket = js.browser.SocketIo.connect();
		var socket = new Client();
		socket.emit("message", "hi");
		socket.emit('send', { message: 'text', username: '_inputName.value' });
		socket.on("visitor enters", function(msg) {
			console.log('current number of visitors (enters): ' + msg);
			new JQuery("#visitors").text('current visitors: ${msg}');
		});
		socket.on("visitor exits", function(msg) {
			console.log('current number of visitors (exits): ' + msg);
			new JQuery("#visitors").text('current visitors: ${msg}');
		});
		socket.on('message', function (data){
			if(data != null){
				trace(data);
			}
		});
	}


	function initPages(){
		console.debug('initPages');
		if(document.getElementsByClassName('page-signin').length > 0 ){
			trace('page-signin');
			new JQuery('form').on('submit', function (e){
				e.preventDefault();
				trace( new JQuery(js.Lib.nativeThis) );
				trace( new JQuery('form').serialize() );
				trace( new JQuery(js.Lib.nativeThis).serialize() );
				trace( new JQuery(js.Lib.nativeThis).attr('action') );
				trace( new JQuery(js.Lib.nativeThis).attr('method') );
				var apiUrl = '/users/';
				JQuery.ajax({
					url: '${apiUrl}${new JQuery(js.Lib.nativeThis).attr('action')}',
					method: new JQuery(js.Lib.nativeThis).attr('method'),
					data: new JQuery(js.Lib.nativeThis).serialize(),
					beforeSend: setRequestHeader
				}).done(function (data) {
					trace(data);
					if (data.token != null) {
						setToken(data.token);
						window.location.replace("/secure");
					}
				});
			});
		}
		if(document.getElementsByClassName('page-register').length > 0 ){
			trace('page-register');
			// new JQuery('body').on('submit', 'form', submittedForm);
			new JQuery('form').on('submit', function (e){
				e.preventDefault();
				trace( new JQuery(js.Lib.nativeThis) );
				trace( new JQuery('form').serialize() );
				trace( new JQuery(js.Lib.nativeThis).serialize() );
				trace( new JQuery(js.Lib.nativeThis).attr('action') );
				trace( new JQuery(js.Lib.nativeThis).attr('method') );
				var apiUrl = '/users/';
				JQuery.ajax({
					url: '${apiUrl}${new JQuery(js.Lib.nativeThis).attr('action')}',
					method: new JQuery(js.Lib.nativeThis).attr('method'),
					data: new JQuery(js.Lib.nativeThis).serialize(),
					beforeSend: setRequestHeader
				}).done(function (data) {
					trace(data);
					if (data.token != null) {
						setToken(data.token);
						window.location.replace("/secure");
					}
				});
			});
		}
		if(document.getElementsByClassName('page-homepage').length > 0 ){
			trace('page-homepage');
		}
	}


	function setToken(token) {
		trace('setToken $token');
		return window.localStorage.setItem('token', token);
	}
	function setRequestHeader(xhr) {
		// trace('setRequestHeader ($xhr)');
		return xhr.setRequestHeader('Authorization', 'Bearer ${getToken()}');
	}
	function getToken() {
		trace('getToken');
		return window.localStorage.getItem('token');
	}

	function submittedForm (e) {
		e.preventDefault();
		// trace(e);
		var apiUrl = '/users/';
		var scope = new JQuery(e.currentTarget);
		var action = scope.attr('action');
		trace(scope);
		trace(action);
		trace(new JQuery(scope).serialize());
		// JQuery.ajax({
		// 	url: '${apiUrl}${action}',
		// 	method: new JQuery(scope).attr('method'),
		// 	data: new JQuery(scope).serialize(),
		// 	// beforeSend: setRequestHeader
		// }).done(function (data) {
		// 	trace(data);
		// 	// if (data.token) setToken(data.token);
		// });
	}

	/**
	 * use vanilla.js to update the view/frontend
	 */
	function initVanillaJs(){
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('> Vanilla.js :: Dom ready');
			if(document.getElementsByClassName('container-vanillajs').length > 0 ){
				loadData();
			}
		});
	}

	function loadData(){
		trace('Vanilla.js loadData');
		var url = '/endpoint/test';
		var req = new haxe.Http(url);
		// req.setHeader('Content-Type', 'application/json');
		// req.setHeader('auth', '${App.TOKEN}');
		req.onData = function (data ) {
			try {
				var json = haxe.Json.parse(data);
				console.log	(json);
				console.log	(json.length);
				// document.getElementById('container-table').innerText = 'hello';
				var html = generateTable(haxe.Json.parse(data));
				document.getElementById('container-table').innerHTML = (html);
			} catch (e:Dynamic){
				trace(e);
			}
		}
		req.onError = function (error : String) {
			trace('error: $error');
		}
		req.onStatus = function (status : Int) {
			trace('status: $status');
		}
		req.request(false);  // false=GET, true=POST
	}

	/**
	 * use jQuery to update the view/frontend
	 */
	function initJQuery(){
		new JQuery( document ).ready(function() {
			console.log('> JQuery :: Dom ready');
			// console.log( document.getElementsByClassName('container-jquery').length );
			// console.log( new JQuery('.container').hasClass('container-jquery') );
			if(document.getElementsByClassName('container-jquery').length > 0 ){
				console.log('start loading `/endpoint/test`');
				JQuery.ajax({
					url: "/endpoint/test",
					dataType: "json",
				}).done(function(data) {
					var json = haxe.Json.parse(haxe.Json.stringify(data));
					console.log(data);
					// console.log('loaded: ${data}');
					var html = generateTable(json);
					new JQuery('#container-table').html(html);
				});
			}
		});
	}

	function generateTable(data:Array<{}>) : String {
		console.log('render table');
		var html = '';
		html += '<table class="table table-hover">
		<thead>
		<tr>
		<th scope="col">#</th>
		<th scope="col">uid</th>
		<th scope="col">Name</th>
		<th scope="col">Email</th>
		<th scope="col">phone</th>
		</tr>
		</thead>
		<tbody>';
		for ( i in 0 ... data.length ) {
			var obj : Dynamic = data[i];
			// trace(obj.uid);
			html += '<tr>
			<th scope="row">${i+1}</th>
			<td>${ obj.uid }</td>
			<td>${ obj.card.name }</td>
			<td><a href="mailto:${ cast (obj.card.email,String).toLowerCase() }">${ cast (obj.card.email,String).toLowerCase() }</a></td>
			<td>${ obj.card.phone }</td>
			</tr>';
		}
		html += '</tbody>
		</table>';
		return html;
	}

	static public function main () {
		var app = new MainClient ();
	}
}