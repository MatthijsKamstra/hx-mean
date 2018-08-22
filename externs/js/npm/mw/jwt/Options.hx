package externs.js.npm.mw.jwt;

import externs.js.npm.express.Request;

typedef Options = {
  ?userProperty : String,
  ?credentialsRequired : Bool,
  ?getToken : Request -> String,
  ?secret : String
}
