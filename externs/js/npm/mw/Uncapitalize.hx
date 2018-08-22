package externs.js.npm.mw;

import externs.js.npm.express.*;

@:jsRequire("express-uncapitalize")
extern class Uncapitalize {
  @:selfCall static function create() : Middleware;
}
