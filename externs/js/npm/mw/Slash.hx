package externs.js.npm.mw;

import externs.js.npm.express.*;

@:jsRequire("express-slash")
extern class Slash {
  @:selfCall static function create(?statusCode : Int) : Middleware;
}
