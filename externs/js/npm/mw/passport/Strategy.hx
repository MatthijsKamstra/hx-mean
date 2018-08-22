package externs.js.npm.mw.passport;

import externs.js.npm.express.Request;

extern class Strategy<T> {
  var name : String;
  function authenticate(request : Request, options : T) : Void;
}
