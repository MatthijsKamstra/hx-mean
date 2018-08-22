package externs.js.npm.mw;

import externs.js.npm.express.Request;
import externs.js.npm.express.Middleware;
import externs.js.npm.mw.cors.*;

@:jsRequire("cors")
extern class Cors {
  @:selfCall static function create(?options : Options) : Middleware;
}