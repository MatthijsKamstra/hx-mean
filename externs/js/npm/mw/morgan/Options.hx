package externs.js.npm.mw.morgan;

import externs.js.npm.express.Request;
import externs.js.npm.express.Response;

typedef Options = {
  ?immediate : Bool,
  ?skip : Request -> Response -> Bool,
  ?stream : js.node.fs.WriteStream
}
