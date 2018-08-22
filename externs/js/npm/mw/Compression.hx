package externs.js.npm.mw;

import externs.js.npm.express.Middleware;
import externs.js.npm.mw.compression.*;

@:jsRequire("compression")
extern class Compression {
  @:selfCall static function create(?options : CompressionOptions) : Middleware;
}
