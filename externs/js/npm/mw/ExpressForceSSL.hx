package externs.js.npm.mw;

import externs.js.npm.mw.expressforcessl.*;
import externs.js.npm.express.*;

@:jsRequire("express-force-ssl")
extern class ExpressForceSSL {
  @:selfCall static var instance(default, null) : Middleware;
}
