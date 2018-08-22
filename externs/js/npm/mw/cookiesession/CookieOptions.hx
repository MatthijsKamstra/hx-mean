package externs.js.npm.mw.cookiesession;

import externs.js.npm.express.Request;
import externs.js.npm.express.Response;

typedef CookieOptions = {
  ?maxAge : Float,
  ?expires : Date,
  ?path : String,
  ?domain : String,
  ?secure : Bool,
  ?secureProxy : Bool,
  ?httpOnly : Bool,
  ?signed : Bool,
  ?overwrite : Bool
}
