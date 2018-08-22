package externs.js.npm.express;

import externs.js.npm.express.Middleware;
import haxe.extern.Rest;

/**
 * Haxe externs for express.js 4.16.3 (4.x)
 * Project: http://expressjs.com/
 * Definitions by:  Franco Ponticelli <https://github.com/fponticelli>
 *                  Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions:     <https://github.com/abedev/hxexpress>
 *                  <https://github.com/matthijskamstra/hx-mean>
 */
@:jsRequire("express")
extern class Express extends Route {
  @:selfCall function new() : Void;

  var locals(default, null) : {};
  var mountpath(default, null) : Array<String>;

  function on(event : ExpressEvent, callback : Express -> Void) : Void;

  function disable(name : String) : Void;
  function disabled(name : String) : Bool;
  function enable(name : String) : Void;
  function enabled(name : String) : Bool;
  function engine(ext : String, callback : String -> {} -> (Error -> String -> Void) -> Void) : Express;

  @:overload(function(name : String) : String {})
  override function get(path : String, callback : Middleware, callbacks : Rest<Middleware>) : Void;

  // TODO return type is wrong
  function listen(port : Int, ?hostname : String, ?backlog : Int, ?callback : Void -> Void) : Dynamic;
  function param(?name : String, callback : Request -> Response -> Next -> String -> Void) : Express;
  function path() : String;
  function render(view : String, ?locals : {}, callback : Error -> String -> Void) : Void;
  function route(path : String) : Route;
  function search(path : String, callback : Middleware, callbacks : Rest<Middleware>) : Void;
  function set(name : String, value : Dynamic) : Express;

  @:overload(function(callback : EitherMiddleware) : Express {})
  @:overload(function(app : Express) : Express {})
  @:overload(function(path : String, app : Express) : Express {})
  @:overload(function(router : Router) : Express {})
  @:overload(function(path : String, router : Router) : Express {})
  function use(path : String, callback : EitherMiddleware, callbacks : Rest<Middleware>) : Express;

  inline static function serveStatic(root : String, ?options : StaticOptions) : Middleware
    return untyped Express["static"](root, options);
}

@:enum
abstract ExpressEvent(String) from String to String {
  var mount = "mount";
}
