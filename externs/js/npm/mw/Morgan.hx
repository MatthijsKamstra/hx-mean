package externs.js.npm.mw;

import externs.js.npm.express.*;
import externs.js.npm.mw.morgan.*;

@:jsRequire("morgan")
extern class Morgan {
  @:selfCall static function create(format : String, ?options : Options) : Middleware;
  static function token(type : String, callback : Request -> Response -> String) : Void;
}
