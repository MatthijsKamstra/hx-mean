// Generated by Haxe 3.4.7
if (process.version < "v04.0.0") console.warn("Module " + (typeof(module) == "undefined" ? "" : module.filename) + " requires node.js version 4.0.0 or higher");
(function () { "use strict";
var Global = function() { };
Global.__name__ = true;
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) {
		return undefined;
	}
	return x;
};
var MainServer = function() {
	this.users = [{ name : "Mark", age : 30},{ name : "John", age : 45},{ name : "Leo", age : 100}];
	this.config = new config_Config();
	var _gthis = this;
	Test.bcrypt();
	var isDev = this.config.ENVIRONMENT == "development";
	console.log("isDev: " + (isDev == null ? "null" : "" + isDev));
	var dummyData = new server_DummyData(isDev);
	var mongoConnect = this.config.MONGO_URL;
	if(this.config.MONGO_URL != "" && this.config.MONGO_USER != "" && this.config.MONGO_PASS != "") {
		mongoConnect = "mongodb://" + this.config.MONGO_USER + ":" + this.config.MONGO_PASS + "@" + this.config.MONGO_URL;
	} else if(this.config.MONGO_URL != "") {
		mongoConnect = "" + this.config.MONGO_URL;
	}
	console.log(mongoConnect);
	MainServer.mongoose = new externs_js_node_mongoose_Mongoose();
	Global.MONGOOSE = MainServer.mongoose;
	MainServer.mongoose.Promise = global.Promise;
	MainServer.mongoose.connect(mongoConnect,{ useNewUrlParser : true});
	var db = MainServer.mongoose.connection;
	db.on("open",function() {
		console.log("Connected to the database \"mongodb://" + MainServer.mongoose.connection.host + ":" + MainServer.mongoose.connection.port + "/" + MainServer.mongoose.connection.name + "\".");
		if(isDev) {
			dummyData.init();
		}
	});
	db.on("error",function(err) {
		console.log("Database error: " + err);
	});
	var app = externs_js_npm_express_Express();
	var root = js_node_Path.join(__dirname,"public");
	app["use"](externs_js_npm_express_Express["static"](root,null));
	app["use"](externs_js_npm_mw_BodyParser.json());
	app["use"](externs_js_npm_mw_BodyParser.urlencoded({ extended : true}));
	app["use"](externs_js_npm_mw_Morgan("dev"));
	if(Object.prototype.hasOwnProperty.call(process.env,"CORS")) {
		app["use"](externs_js_npm_mw_Cors());
	}
	app.set("port",this.config.PORT);
	app.set("views",__dirname + "/public/");
	if(isDev) {
		app.set("json spaces",2);
	}
	app.engine("html",swig.renderFile);
	app.set("view engine","html");
	app.set("views",__dirname + "/views/swig");
	app.set("view cache",!isDev);
	swig.setDefaults({ cache : false});
	swig.setExtension("isDev",isDev);
	swig.setExtension("now",new Date());
	app.get("/swig",function(req,res) {
		res.render("_index",{ title : "Swig Template Example", users : _gthis.users});
	});
	app.get("/jquery",function(req1,res1) {
		res1.render("_jquery",{ title : "Swig/jQuery Template Example"});
	});
	app.get("/vanillajs",function(req2,res2) {
		res2.render("_vanillajs",{ title : "Swig/Vanilla.js Template Example"});
	});
	app["use"]("/index",new server_routes_Index().router);
	app["use"]("/api",new server_routes_Api().router);
	app["use"]("/endpoint",new server_routes_Endpoint().router);
	app["use"]("/users",new server_routes_Users().router);
	app.get("/",function(req3,res3) {
		res3.sendFile(__dirname + "/public/index.html");
	});
	app.get("/remote",function(req4,res4) {
		res4.sendFile(__dirname + "/public/remote.html");
	});
	app.get("/signin",function(req5,res5) {
		res5.sendFile(__dirname + "/public/signin.html");
	});
	app.get("/test",function(req6,res6) {
		res6.render("_test",{ title : "Test"});
	});
	app.get("/api/users",function(req7,res7) {
		var username = req7.param("username");
		res7.send("username: " + username);
	});
	app["use"](function(req8,res8,next) {
		res8.sendFile(js_node_Path.resolve(__dirname,"public/400.html"));
	});
	var server1 = app.listen(this.config.PORT,null,null,function() {
		console.info(">>> 🌎 Open http://localhost:" + _gthis.config.PORT + "/ in your browser.");
	});
	var io = new externs_js_node_socketio_Server();
	io.listen(server1);
	var online = 0;
	io.on("connection",function(socket) {
		online += 1;
		console.log("Socket " + socket.id + " connected.");
		console.log("Online: " + online);
		io.emit("visitor enters",online);
		socket.emit("message",{ message : "welcome to the chat"});
		socket.on("disconnect",function(socket1) {
			online -= 1;
			console.log("Socket " + socket1.id + " disconnected.");
			console.log("Online: " + online);
			io.emit("visitor exits",online);
		});
		socket.on("send",function(data) {
			io.sockets.emit("message",data);
		});
	});
};
MainServer.__name__ = true;
MainServer.main = function() {
	var main = new MainServer();
};
Math.__name__ = true;
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.getProperty = function(o,field) {
	var tmp;
	if(o == null) {
		return null;
	} else {
		var tmp1;
		if(o.__properties__) {
			tmp = o.__properties__["get_" + field];
			tmp1 = tmp;
		} else {
			tmp1 = false;
		}
		if(tmp1) {
			return o[tmp]();
		} else {
			return o[field];
		}
	}
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
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
var Test = function() { };
Test.__name__ = true;
Test.bcrypt = function() {
	var password = "ikbeneenpassword";
	var t = bcrypt.hashSync(password,bcrypt.genSaltSync(8));
	haxe_Log.trace(t,{ fileName : "Test.hx", lineNumber : 142, className : "Test", methodName : "bcrypt"});
};
var config_Config = function() {
	this.ENVIRONMENT = Object.prototype.hasOwnProperty.call(process.env,"ENVIRONMENT") ? process.env["ENVIRONMENT"] : "development";
	this.PORT = Object.prototype.hasOwnProperty.call(process.env,"PORT") ? Std.parseInt(process.env["PORT"]) : 8000;
	this.MONGO_URL = Object.prototype.hasOwnProperty.call(process.env,"MONGO_URL") ? process.env["MONGO_URL"] : "mongodb://localhost:27017/hxmean";
	this.MONGO_USER = Object.prototype.hasOwnProperty.call(process.env,"MONGO_USER") ? process.env["MONGO_USER"] : "";
	this.MONGO_PASS = Object.prototype.hasOwnProperty.call(process.env,"MONGO_PASS") ? process.env["MONGO_PASS"] : "";
};
config_Config.__name__ = true;
var externs_js_node_mongoose_Mongoose = require("mongoose").Mongoose;
var externs_js_node_mongoose_Schema = require("mongoose").Schema;
var externs_js_node_socketio_Server = require("socket.io");
var bcrypt = require("Bcrypt");
var jwt = require("jsonwebtoken");
var swig = require("swig-templates");
var validator = require("validator");
var externs_js_npm_express_Express = require("express");
var externs_js_npm_express_Router = require("express").Router;
var externs_js_npm_mw_BodyParser = require("body-parser");
var externs_js_npm_mw_Cors = require("cors");
var externs_js_npm_mw_Morgan = require("morgan");
var haxe_Log = function() { };
haxe_Log.__name__ = true;
haxe_Log.trace = function(v,infos) {
	js_Boot.__trace(v,infos);
};
var haxe_io_Bytes = function(data) {
	this.length = data.byteLength;
	this.b = new Uint8Array(data);
	this.b.bufferValue = data;
	data.hxBytes = this;
	data.bytes = this.b;
};
haxe_io_Bytes.__name__ = true;
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
};
js_Boot.__trace = function(v,i) {
	var msg = i != null ? i.fileName + ":" + i.lineNumber + ": " : "";
	msg += js_Boot.__string_rec(v,"");
	if(i != null && i.customParams != null) {
		var _g = 0;
		var _g1 = i.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			msg += "," + js_Boot.__string_rec(v1,"");
		}
	}
	var d;
	var tmp;
	if(typeof(document) != "undefined") {
		d = document.getElementById("haxe:trace");
		tmp = d != null;
	} else {
		tmp = false;
	}
	if(tmp) {
		d.innerHTML += js_Boot.__unhtml(msg) + "<br/>";
	} else if(typeof console != "undefined" && console.log != null) {
		console.log(msg);
	}
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) {
					return o[0];
				}
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) {
						str += "," + js_Boot.__string_rec(o[i],s);
					} else {
						str += js_Boot.__string_rec(o[i],s);
					}
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g11 = 0;
			var _g2 = l;
			while(_g11 < _g2) {
				var i2 = _g11++;
				str1 += (i2 > 0 ? "," : "") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) {
			str2 += ", \n";
		}
		str2 += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var js_node_Path = require("path");
var js_node_buffer_Buffer = require("buffer").Buffer;
var faker = require("faker");
var server_DummyData = function(isDev) {
	if(isDev == null) {
		isDev = false;
	}
	faker.locale = "nl";
	var randomName = faker.name.findName();
	var randomEmail = faker.internet.email();
	var randomCard = faker.helpers.createCard();
	if(isDev) {
		haxe_Log.trace("" + randomName + ", " + randomEmail,{ fileName : "DummyData.hx", lineNumber : 24, className : "server.DummyData", methodName : "new"});
	}
};
server_DummyData.__name__ = true;
server_DummyData.prototype = {
	init: function() {
		this.registerUsers();
		this.user();
		this.trashCollection();
		this.chatLog();
	}
	,user: function() {
		haxe_Log.trace("users",{ fileName : "DummyData.hx", lineNumber : 36, className : "server.DummyData", methodName : "user"});
	}
	,chatLog: function() {
		haxe_Log.trace("registerUsers",{ fileName : "DummyData.hx", lineNumber : 57, className : "server.DummyData", methodName : "chatLog"});
	}
	,registerUsers: function() {
		haxe_Log.trace("registerUsers",{ fileName : "DummyData.hx", lineNumber : 62, className : "server.DummyData", methodName : "registerUsers"});
		var r = new server_models_RegisterUsers();
		r.count(function(count) {
			if(count == 0) {
				var _g = 0;
				while(_g < 10) {
					var i = _g++;
					var obj = { uid : faker.random.uuid(), street_number : faker.random.number(), postal_code : faker.address.zipCode(), ismember : faker.random["boolean"]()};
					r.add(obj,function() {
						haxe_Log.trace("done",{ fileName : "DummyData.hx", lineNumber : 75, className : "server.DummyData", methodName : "registerUsers"});
					});
				}
			}
		});
	}
	,trashCollection: function() {
		haxe_Log.trace("trashCollection",{ fileName : "DummyData.hx", lineNumber : 84, className : "server.DummyData", methodName : "trashCollection"});
	}
};
var server_models_RegisterUsers = function() {
	this.mongoose = MainServer.mongoose;
	this.schema = new externs_js_node_mongoose_Schema({ uid : String, street_number : "Number", postal_code : String, ismember : "Boolean"});
	this.model = this.mongoose.model("RegisterUsers",this.schema);
};
server_models_RegisterUsers.__name__ = true;
server_models_RegisterUsers.prototype = {
	add: function(obj,callback) {
		this.model.create(obj,function(err,_created) {
			callback(_created);
			haxe_Log.trace(_created,{ fileName : "RegisterUsers.hx", lineNumber : 50, className : "server.models.RegisterUsers", methodName : "add"});
		});
	}
	,count: function(callback) {
		this.model.countDocuments({ },function(err,count) {
			callback(count);
		});
	}
};
var server_models_User = function() {
	this.mongoose = MainServer.mongoose;
	this.schema = new externs_js_node_mongoose_Schema({ username : { type : String, unique : true, required : true}, email : { type : String, unique : true, required : true}, passwordHash : { type : String, unique : true, required : true}});
	this.schema.virtual("password").set($bind(this,this.setPassword));
	this.schema.virtual("passwordConfirmation").set($bind(this,this.setPasswordConfirmation));
	this.schema.path("passwordHash").validate($bind(this,this.validatePasswordHash));
	this.schema.path("email").validate($bind(this,this.validateEmail));
	this.schema.method("validatePassword",$bind(this,this.validatePassword));
	this.model = this.mongoose.model("User",this.schema);
};
server_models_User.__name__ = true;
server_models_User.prototype = {
	setPassword: function(password) {
		console.log("setPassword - " + password);
		this._password = password;
		this.passwordHash = bcrypt.hashSync(password,bcrypt.genSaltSync(8));
		console.log("" + Std.string(this._password) + " & " + Std.string(this.passwordHash));
	}
	,setPasswordConfirmation: function(passwordConfirmation) {
		this._passwordConfirmation = passwordConfirmation;
	}
	,validateEmail: function(email) {
		if(!validator.isEmail(email)) {
			return this.invalidate("email","A valid e-mail address is required.");
		} else {
			return true;
		}
	}
	,validatePassword: function(password) {
		return bcrypt.compareSync(password,this.passwordHash);
	}
	,validatePasswordHash: function() {
		console.log(this);
		return true;
	}
	,create: function(obj,callback) {
		haxe_Log.trace("create ( " + Std.string(obj) + ")",{ fileName : "User.hx", lineNumber : 108, className : "server.models.User", methodName : "create"});
		this.model.create(obj,function(err,_created) {
			callback(_created);
			haxe_Log.trace(_created,{ fileName : "User.hx", lineNumber : 111, className : "server.models.User", methodName : "create"});
		});
	}
};
var server_routes_Api = function() {
	this.router = externs_js_npm_express_Router();
	this.router.get("/",function(req,res) {
		res.end("Api");
	});
	this.router.get("/test",function(req1,res1) {
		res1.end("Api/test");
	});
	this.router.get("/superheros",function(req2,res2) {
		haxe_Log.trace(req2.body.name,{ fileName : "Api.hx", lineNumber : 22, className : "server.routes.Api", methodName : "new"});
		res2.redirect("/api/test");
	});
	this.router.get("/id/:id",function(req3,res3) {
		var id = req3.params.id;
		var json = { id : id, status : "ok"};
		res3.json(json);
	});
	this.router.post("/register",function(req4,res4) {
		var json1 = JSON.parse(JSON.stringify(req4.body));
		haxe_Log.trace("body: ",{ fileName : "Api.hx", lineNumber : 37, className : "server.routes.Api", methodName : "new", customParams : [json1]});
		return res4.status(500).json({ success : false, msg : "hello"});
	});
	this.router["delete"]("/:id",function(req5,res5) {
		var id1 = req5.params.id;
		var json2 = { id : id1, status : "ok"};
		res5.json(json2);
	});
	this.router.put("/:id",function(req6,res6) {
		var id2 = req6.params.id;
		var json3 = { id : id2, status : "ok"};
		res6.json(json3);
	});
	this.router.get("/register/all",function(req7,res7) {
		var json4 = { total : 100, status : "ok"};
		res7.json(json4);
	});
};
server_routes_Api.__name__ = true;
var server_routes_Endpoint = function() {
	this.router = externs_js_npm_express_Router();
	this.router.get("/",function(req,res) {
		res.end("Endpoint");
	});
	this.router.get("/test",function(req1,res1) {
		var arr = [];
		var json = arr;
		var _g = 0;
		while(_g < 10) {
			var i = _g++;
			var obj = { uid : faker.random.uuid(), card : faker.helpers.createCard()};
			arr.push(obj);
		}
		res1.json(JSON.parse(JSON.stringify(arr)));
	});
	this.router.get("/superhero",function(req2,res2) {
		res2.end("superhero");
	});
	this.router.get("/id/:id",function(req3,res3) {
		var id = Reflect.getProperty(req3.params,"id");
		var json1 = { id : id, status : "ok"};
		res3.json(json1);
	});
};
server_routes_Endpoint.__name__ = true;
var server_routes_Index = function() {
	this.router = externs_js_npm_express_Router();
	this.router.get("/",function(req,res) {
		res.end("Index");
	});
};
server_routes_Index.__name__ = true;
var server_routes_Users = function() {
	this.router = externs_js_npm_express_Router();
	this.router.get("/",function(req,res) {
		res.end("users");
	});
	this.router.get("/register",function(req1,res1) {
		var u = new server_models_User();
		if(!Object.prototype.hasOwnProperty.call(req1.body,"user")) {
			req1.body["user"] = { username : "Matthijs", email : "matthijs@foo.bar", password : "test"};
		}
		u.create(Reflect.getProperty(req1.body,"user"),function(err,user) {
			if(err != null) {
				return res1.status(500).json({ message : "Something went wrong (" + err + ")."});
			}
			var token = jwt.sign(user._id,config_Config.SECRET,{ expiresIn : 86400});
			var tmp = "Welcome " + user.username + "!";
			return res1.status(201).json({ message : tmp, user : user, token : token});
		});
	});
	this.router.get("/login",function(req2,res2) {
		res2.end("users/login");
	});
};
server_routes_Users.__name__ = true;
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = ["Date"];
config_Config.SECRET = "something top secret, Haxe related and MEAN";
MainServer.main();
})();
