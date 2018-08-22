package externs.js.npm.mw.bodyparser;

import externs.js.npm.express.Request;
import externs.js.npm.express.Response;
import haxe.extern.EitherType;
import js.node.Buffer;

typedef RawOptions = {
  ?inflate : Bool,
  ?limit : EitherType<String, Int>,
  ?type : EitherType<String, Request -> Bool>,
  ?verify : Request -> Response -> Buffer -> String -> Void
}
