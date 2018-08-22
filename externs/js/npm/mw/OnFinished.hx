package externs.js.npm.mw;

import externs.js.npm.express.Request;
import externs.js.npm.express.Response;
import js.Error;

@:jsRequire("on-finished")
extern class OnFinished {
  @:overload(function(req : Request, callback : Null<Error> -> Request -> Void) : Void {})
  @:selfCall static function listen(res : Response, callback : Null<Error> -> Response -> Void) : Void;

  @:overload(function(req : Request) : Bool {})
  static function isFinished(res : Response) : Bool;
}
