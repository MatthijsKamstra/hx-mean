package externs.js.npm.mw;

import externs.js.npm.express.Middleware;
import externs.js.npm.mw.busboy.Options;

@:jsRequire("connect-busboy")
extern class Busboy {
  @:selfCall static function create(?options : Options) : Middleware;
}
