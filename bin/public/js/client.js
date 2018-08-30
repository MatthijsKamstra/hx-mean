// Generated by Haxe 3.4.7
(function ($global) { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var EReg = function(r,opt) {
	this.r = new RegExp(r,opt.split("u").join(""));
};
EReg.__name__ = true;
EReg.prototype = {
	match: function(s) {
		if(this.r.global) {
			this.r.lastIndex = 0;
		}
		this.r.m = this.r.exec(s);
		this.r.s = s;
		return this.r.m != null;
	}
	,__class__: EReg
};
var Lambda = function() { };
Lambda.__name__ = true;
Lambda.exists = function(it,f) {
	var x = it.iterator();
	while(x.hasNext()) {
		var x1 = x.next();
		if(f(x1)) {
			return true;
		}
	}
	return false;
};
var List = function() {
	this.length = 0;
};
List.__name__ = true;
List.prototype = {
	iterator: function() {
		return new _$List_ListIterator(this.h);
	}
	,__class__: List
};
var _$List_ListNode = function(item,next) {
	this.item = item;
	this.next = next;
};
_$List_ListNode.__name__ = true;
_$List_ListNode.prototype = {
	__class__: _$List_ListNode
};
var _$List_ListIterator = function(head) {
	this.head = head;
};
_$List_ListIterator.__name__ = true;
_$List_ListIterator.prototype = {
	hasNext: function() {
		return this.head != null;
	}
	,next: function() {
		var val = this.head.item;
		this.head = this.head.next;
		return val;
	}
	,__class__: _$List_ListIterator
};
var MainClient = function() {
	this.initJQuery();
	this.initVanillaJs();
	if(window.document.getElementById("visitors") == null) {
		var div = window.document.createElement("div");
		div.id = "visitors";
		div.className = "container";
		window.document.body.appendChild(div);
	}
	var socket = typeof io == 'undefined' ? require('socket.io-client') : io();
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
MainClient.__name__ = true;
MainClient.main = function() {
	var app = new MainClient();
};
MainClient.prototype = {
	initVanillaJs: function() {
		var _gthis = this;
		window.document.addEventListener("DOMContentLoaded",function(event) {
			window.console.log("> Vanilla.js :: Dom ready");
			if(window.document.getElementsByClassName("container-vanillajs").length > 0) {
				_gthis.loadData();
			}
		});
	}
	,loadData: function() {
		var _gthis = this;
		console.log("Vanilla.js loadData");
		var url = "/endpoint/test";
		var req = new haxe_Http(url);
		req.onData = function(data) {
			try {
				var json = JSON.parse(data);
				window.console.log(json);
				window.console.log(json.length);
				var html = JSON.parse(data);
				var html1 = _gthis.generateTable(html);
				window.document.getElementById("container-table").innerHTML = html1;
			} catch( e ) {
				if (e instanceof js__$Boot_HaxeError) e = e.val;
				console.log(e);
			}
		};
		req.onError = function(error) {
			console.log("error: " + error);
		};
		req.onStatus = function(status) {
			console.log("status: " + status);
		};
		req.request(false);
	}
	,initJQuery: function() {
		var _gthis = this;
		$(window.document).ready(function() {
			window.console.log("> JQuery :: Dom ready");
			if(window.document.getElementsByClassName("container-jquery").length > 0) {
				window.console.log("start loading `/endpoint/test`");
				$.ajax({ url : "/endpoint/test", dataType : "json"}).done(function(data) {
					var json = JSON.parse(JSON.stringify(data));
					window.console.log(data);
					var html = _gthis.generateTable(json);
					$("#container-table").html(html);
				});
			}
		});
	}
	,generateTable: function(data) {
		window.console.log("render table");
		var html = "";
		html += "<table class=\"table table-hover\">\n\t\t<thead>\n\t\t<tr>\n\t\t<th scope=\"col\">#</th>\n\t\t<th scope=\"col\">uid</th>\n\t\t<th scope=\"col\">Name</th>\n\t\t<th scope=\"col\">Email</th>\n\t\t<th scope=\"col\">phone</th>\n\t\t</tr>\n\t\t</thead>\n\t\t<tbody>";
		var _g1 = 0;
		var _g = data.length;
		while(_g1 < _g) {
			var i = _g1++;
			var obj = data[i];
			html += "<tr>\n\t\t\t<th scope=\"row\">" + (i + 1) + "</th>\n\t\t\t<td>" + Std.string(obj.uid) + "</td>\n\t\t\t<td>" + Std.string(obj.card.name) + "</td>\n\t\t\t<td><a href=\"mailto:" + (js_Boot.__cast(obj.card.email , String)).toLowerCase() + "\">" + (js_Boot.__cast(obj.card.email , String)).toLowerCase() + "</a></td>\n\t\t\t<td>" + Std.string(obj.card.phone) + "</td>\n\t\t\t</tr>";
		}
		html += "</tbody>\n\t\t</table>";
		return html;
	}
	,__class__: MainClient
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var haxe_Http = function(url) {
	this.url = url;
	this.headers = new List();
	this.params = new List();
	this.async = true;
	this.withCredentials = false;
};
haxe_Http.__name__ = true;
haxe_Http.prototype = {
	request: function(post) {
		var me = this;
		me.responseData = null;
		var r = this.req = js_Browser.createXMLHttpRequest();
		var onreadystatechange = function(_) {
			if(r.readyState != 4) {
				return;
			}
			var s;
			try {
				s = r.status;
			} catch( e ) {
				s = null;
			}
			if(s != null && "undefined" !== typeof window) {
				var protocol = window.location.protocol.toLowerCase();
				var rlocalProtocol = new EReg("^(?:about|app|app-storage|.+-extension|file|res|widget):$","");
				var isLocal = rlocalProtocol.match(protocol);
				if(isLocal) {
					if(r.responseText != null) {
						s = 200;
					} else {
						s = 404;
					}
				}
			}
			if(s == undefined) {
				s = null;
			}
			if(s != null) {
				me.onStatus(s);
			}
			if(s != null && s >= 200 && s < 400) {
				me.req = null;
				me.onData(me.responseData = r.responseText);
			} else if(s == null) {
				me.req = null;
				me.onError("Failed to connect or resolve host");
			} else {
				switch(s) {
				case 12007:
					me.req = null;
					me.onError("Unknown host");
					break;
				case 12029:
					me.req = null;
					me.onError("Failed to connect to host");
					break;
				default:
					me.req = null;
					me.responseData = r.responseText;
					me.onError("Http Error #" + r.status);
				}
			}
		};
		if(this.async) {
			r.onreadystatechange = onreadystatechange;
		}
		var uri = this.postData;
		if(uri != null) {
			post = true;
		} else {
			var _g_head = this.params.h;
			while(_g_head != null) {
				var val = _g_head.item;
				_g_head = _g_head.next;
				var p = val;
				if(uri == null) {
					uri = "";
				} else {
					uri += "&";
				}
				var s1 = p.param;
				var uri1 = encodeURIComponent(s1) + "=";
				var s2 = p.value;
				uri += uri1 + encodeURIComponent(s2);
			}
		}
		try {
			if(post) {
				r.open("POST",this.url,this.async);
			} else if(uri != null) {
				var question = this.url.split("?").length <= 1;
				r.open("GET",this.url + (question ? "?" : "&") + uri,this.async);
				uri = null;
			} else {
				r.open("GET",this.url,this.async);
			}
		} catch( e1 ) {
			if (e1 instanceof js__$Boot_HaxeError) e1 = e1.val;
			me.req = null;
			this.onError(e1.toString());
			return;
		}
		r.withCredentials = this.withCredentials;
		if(!Lambda.exists(this.headers,function(h) {
			return h.header == "Content-Type";
		}) && post && this.postData == null) {
			r.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		}
		var _g_head1 = this.headers.h;
		while(_g_head1 != null) {
			var val1 = _g_head1.item;
			_g_head1 = _g_head1.next;
			var h1 = val1;
			r.setRequestHeader(h1.header,h1.value);
		}
		r.send(uri);
		if(!this.async) {
			onreadystatechange(null);
		}
	}
	,onData: function(data) {
	}
	,onError: function(msg) {
	}
	,onStatus: function(status) {
	}
	,__class__: haxe_Http
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) {
		Error.captureStackTrace(this,js__$Boot_HaxeError);
	}
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.wrap = function(val) {
	if((val instanceof Error)) {
		return val;
	} else {
		return new js__$Boot_HaxeError(val);
	}
};
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
	__class__: js__$Boot_HaxeError
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) {
		return Array;
	} else {
		var cl = o.__class__;
		if(cl != null) {
			return cl;
		}
		var name = js_Boot.__nativeClassName(o);
		if(name != null) {
			return js_Boot.__resolveNativeClass(name);
		}
		return null;
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
js_Boot.__interfLoop = function(cc,cl) {
	if(cc == null) {
		return false;
	}
	if(cc == cl) {
		return true;
	}
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js_Boot.__interfLoop(i1,cl)) {
				return true;
			}
		}
	}
	return js_Boot.__interfLoop(cc.__super__,cl);
};
js_Boot.__instanceof = function(o,cl) {
	if(cl == null) {
		return false;
	}
	switch(cl) {
	case Array:
		if((o instanceof Array)) {
			return o.__enum__ == null;
		} else {
			return false;
		}
		break;
	case Bool:
		return typeof(o) == "boolean";
	case Dynamic:
		return true;
	case Float:
		return typeof(o) == "number";
	case Int:
		if(typeof(o) == "number") {
			return (o|0) === o;
		} else {
			return false;
		}
		break;
	case String:
		return typeof(o) == "string";
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) {
					return true;
				}
				if(js_Boot.__interfLoop(js_Boot.getClass(o),cl)) {
					return true;
				}
			} else if(typeof(cl) == "object" && js_Boot.__isNativeObj(cl)) {
				if(o instanceof cl) {
					return true;
				}
			}
		} else {
			return false;
		}
		if(cl == Class ? o.__name__ != null : false) {
			return true;
		}
		if(cl == Enum ? o.__ename__ != null : false) {
			return true;
		}
		return o.__enum__ == cl;
	}
};
js_Boot.__cast = function(o,t) {
	if(js_Boot.__instanceof(o,t)) {
		return o;
	} else {
		throw new js__$Boot_HaxeError("Cannot cast " + Std.string(o) + " to " + Std.string(t));
	}
};
js_Boot.__nativeClassName = function(o) {
	var name = js_Boot.__toStr.call(o).slice(8,-1);
	if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") {
		return null;
	}
	return name;
};
js_Boot.__isNativeObj = function(o) {
	return js_Boot.__nativeClassName(o) != null;
};
js_Boot.__resolveNativeClass = function(name) {
	return $global[name];
};
var js_Browser = function() { };
js_Browser.__name__ = true;
js_Browser.createXMLHttpRequest = function() {
	if(typeof XMLHttpRequest != "undefined") {
		return new XMLHttpRequest();
	}
	if(typeof ActiveXObject != "undefined") {
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
	throw new js__$Boot_HaxeError("Unable to create XMLHttpRequest object.");
};
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
js_Boot.__toStr = ({ }).toString;
MainClient.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
