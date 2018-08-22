package externs.js.npm.mw;

import externs.js.npm.express.Middleware;
import externs.js.npm.mw.cookiesession.*;

@:jsRequire("cookie-session")
extern class CookieSession {
  @:selfCall static function create(?options : SessionOptions, ?cookieOptions : CookieOptions) : Middleware;
}
