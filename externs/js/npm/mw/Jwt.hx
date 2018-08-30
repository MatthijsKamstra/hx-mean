package externs.js.npm.mw;

import externs.js.npm.mw.Unless;
import externs.js.npm.mw.jwt.Options;


// https://github.com/auth0/express-jwt

/**
 * Haxe externs for express-jwt v5.3.1
 * Project: https://github.com/auth0/express-jwt
 * Definitions by:  Franco Ponticelli <https://github.com/fponticelli>
 *                  Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions:     <https://github.com/abedev/hxexpress>
 *                  <https://github.com/matthijskamstra/hx-mean>
 */
@:jsRequire("express-jwt")
extern class Jwt {
  @:selfCall static function create(?options : Options) : UnlessMiddleware;
}