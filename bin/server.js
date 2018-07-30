// Generated by Haxe 3.4.7
if (process.version < "v4.0.0") console.warn("Module " + (typeof(module) == "undefined" ? "" : module.filename) + " requires node.js version 4.0.0 or higher");
(function () { "use strict";
var HxOverrides = function() { };
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) {
		return undefined;
	}
	return x;
};
var MainServer = function() {
	this.config = new config_Config();
	var _gthis = this;
	var isDev = this.config.ENVIRONMENT == "development";
	console.log("isDev: " + (isDev == null ? "null" : "" + isDev));
	var app = new js_npm_Express();
	app["use"](new js_npm_express_Static(js_node_Path.join(__dirname,"public")));
	app["use"](js_npm_express_BodyParser.json());
	app["use"](js_npm_express_BodyParser.urlencoded({ extended : true}));
	app["use"](new js_npm_express_Morgan("dev"));
	app.set("port",this.config.PORT);
	app.set("views",__dirname + "/public/");
	app.engine("html",js_npm_Swig.renderFile);
	app.set("view engine","html");
	app.set("views",__dirname + "/views/swig");
	app.set("view cache",!isDev);
	js_npm_Swig.setDefaults({ cache : false});
	js_npm_Swig.setExtension("isDev",isDev);
	js_npm_Swig.setExtension("now",new Date());
	app.get("/swig",function(req,res) {
		var users = [{ name : "Mark", age : 30},{ name : "John", age : 45},{ name : "Leo", age : 100}];
		res.render("_index",{ title : "Home", users : users});
	});
	app.get("/",function(req1,res1) {
		res1.sendFile(__dirname + "/public/index.html");
	});
	app.get("/remote",function(req2,res2) {
		res2.sendFile(__dirname + "/public/remote_intermediate.html");
	});
	app.get("/jade",function(req3,res3) {
		res3.render("index",{ title : "Home", h1 : "Title"});
	});
	app.get("/api/users",function(req4,res4) {
		var username = req4.param("username");
		res4.send("username: " + username);
	});
	app["use"](function(req5,res5,next) {
		res5.sendFile(js_node_Path.resolve(__dirname,"public/400.html"));
	});
	app["use"](function(err,req6,res6,next1) {
		var tmp = js_node_Path.resolve(__dirname,"public/500.html");
		res6.sendFile(tmp);
	});
	app.listen(this.config.PORT,function() {
		console.info(">>> 🌎 Open http://localhost:" + _gthis.config.PORT + "/ in your browser.");
	});
};
MainServer.main = function() {
	var main = new MainServer();
};
var Std = function() { };
Std.parseInt = function(x) {
	var v = parseInt(x,10);
	if(v == 0 && (HxOverrides.cca(x,1) == 120 || HxOverrides.cca(x,1) == 88)) {
		v = parseInt(x);
	}
	if(isNaN(v)) {
		return null;
	}
	return v;
};
var config_Config = function() {
	this.ENVIRONMENT = Object.prototype.hasOwnProperty.call(process.env,"ENVIRONMENT") ? process.env["ENVIRONMENT"] : "development";
	this.PORT = Object.prototype.hasOwnProperty.call(process.env,"PORT") ? Std.parseInt(process.env["PORT"]) : 8000;
	this.MONGO_URL = Object.prototype.hasOwnProperty.call(process.env,"MONGO_URL") ? process.env["MONGO_URL"] : "mongodb://localhost:27017/hxmean";
	this.MONGO_USER = Object.prototype.hasOwnProperty.call(process.env,"MONGO_USER") ? process.env["MONGO_USER"] : "";
	this.MONGO_PASS = Object.prototype.hasOwnProperty.call(process.env,"MONGO_PASS") ? process.env["MONGO_PASS"] : "";
};
var haxe_io_Bytes = function(data) {
	this.length = data.byteLength;
	this.b = new Uint8Array(data);
	this.b.bufferValue = data;
	data.hxBytes = this;
	data.bytes = this.b;
};
var js_node_Path = require("path");
var js_node_buffer_Buffer = require("buffer").Buffer;
var js_npm_Express = require("express");
var js_npm_Swig = require("swig-templates");
var js_npm_express_BodyParser = require("body-parser");
var js_npm_express_Morgan = require("morgan");
var js_npm_express_Static = require("express").static;
MainServer.main();
})();
