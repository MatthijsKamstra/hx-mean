package externs.js.npm.express;

import haxe.extern.EitherType;
import haxe.extern.Rest;

/**
 * Haxe externs for express.js 4.16.3 (4.x)
 * Project: http://expressjs.com/
 * Definitions by:  Franco Ponticelli <https://github.com/fponticelli>
 *                  Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions:     <https://github.com/abedev/hxexpress>
 *                  <https://github.com/matthijskamstra/hx-mean>
 */

// https://expressjs.com/en/4x/api.html#req
extern class Request extends js.node.http.IncomingMessage {
  var app : Express;
  var baseUrl : String;
  var body : {};

  //var cookies : {}; // TODO requires middleware

  var fresh : Bool;
  var hostname : String;
  var ip : String;
  var ips : Array<String>;

  // https://expressjs.com/en/4x/api.html#req.method
  // var method : String;

  var originalUrl : String;
  var params : {};
  var path : String;
  var protocol : String; // TODO needs abstract
  var query : {};
  var route : String;
  var secure : Bool;

  //var signedCookies : {}; // TODO requires middleware

  var stale : Bool;
  var subdomains : Array<String>;
  var xhr : Bool;

  @:overload(function(types : Array<String>) : String {})
  function accepts(type : String) : String;

  function acceptsCharsets(charset : String, charsets : Rest<String>) : String;
  function acceptsEncodings(encoding : String, encodings : Rest<String>) : String;
  function acceptsLanguages(languageg : String, languages : Rest<String>) : String;

  function get(field : String) : String;
  @:overload(function(types : Array<String>) : EitherType<String, Bool> {})
  function is(type : String) : EitherType<String, Bool>;
  function param(name : String, ?defaultValue : String) : String;
}
