package externs.js.npm.mw.expressbrute;

import haxe.extern.EitherType;
import externs.js.npm.express.*;

typedef MiddlewareOptions = {
  key : EitherType<String, Request -> Response -> Next -> Void>,
  ?failCallback : Request -> Response -> Next -> Date -> Void
}
