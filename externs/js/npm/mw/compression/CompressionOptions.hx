package externs.js.npm.mw.compression;

import externs.js.npm.express.Request;
import externs.js.npm.express.Response;
import haxe.extern.EitherType;

typedef CompressionOptions = {
  ?chunkSize : Int,
  ?filter : Request -> Response -> Bool,
  ?level : Int,
  ?memLevel : Int,
  ?strategy : String,
  ?threshold : EitherType<Int, EitherType<String, Bool>>,
  ?windowBits : Int
}
