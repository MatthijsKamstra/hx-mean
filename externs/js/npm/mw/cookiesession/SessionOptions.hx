package externs.js.npm.mw.cookiesession;

import externs.js.npm.express.Request;
import externs.js.npm.express.Response;

typedef SessionOptions = {
  ?name : String,
  ?keys : Array<String>,
  ?secret : String
}
