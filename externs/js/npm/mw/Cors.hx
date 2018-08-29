package externs.js.npm.mw;

import externs.js.npm.express.Request;
import externs.js.npm.express.Middleware;
import externs.js.npm.mw.cors.*;

/**
 * Haxe externs for express/cors v2.8.4
 * Project: https://github.com/expressjs/cors
 * Definitions by:  Franco Ponticelli <https://github.com/fponticelli>
 *                  Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions:     <https://github.com/abedev/hxexpress>
 *                  <https://github.com/matthijskamstra/hx-mean>
 */
@:jsRequire("cors")
extern class Cors {
  @:selfCall static function create(?options : Options) : Middleware;
}