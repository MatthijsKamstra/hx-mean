package externs.js.npm.mw;

import externs.js.npm.express.Middleware;
import externs.js.npm.mw.bodyparser.*;

@:jsRequire("body-parser")
extern class BodyParser {
  static function json(?options : JsonOptions) : Middleware;
  static function raw(?options : RawOptions) : Middleware;
  static function text(?options : TextOptions) : Middleware;
  static function urlencoded(?options : UrlEncodedOptions) : Middleware;
}
