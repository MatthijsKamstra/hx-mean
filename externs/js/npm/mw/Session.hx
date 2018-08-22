package externs.js.npm.mw;

@:jsRequire("express-session")
extern class Session
{
	@:selfCall static function create( options:Dynamic ) : externs.js.npm.express.Middleware;
}