package externs.js.npm.mw.expressbrute;

@:jsRequire("express-brute", "MemoryStore")
extern class MemoryStore implements Store {
  function new() : Void;
}
