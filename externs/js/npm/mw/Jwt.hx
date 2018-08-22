package externs.js.npm.mw;

import externs.js.npm.mw.Unless;
import externs.js.npm.mw.jwt.Options;

@:jsRequire("express-jwt")
extern class Jwt {
  @:selfCall static function create(?options : Options) : UnlessMiddleware;
}