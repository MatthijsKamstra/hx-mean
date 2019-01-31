package externs.js.npm;

import haxe.extern.EitherType;

import js.Error;
import js.node.Buffer;


/**
 * Haxe externs for jsonwebtoken v8.3.0
 * Project: https://github.com/auth0/node-jsonwebtoken
 * Definitions by: Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions: <https://github.com/matthijskamstra/hx-mean>
 */
// @:native('jwt')
@:jsRequire("jsonwebtoken")
extern class JsonWebToken{

	@:overload(function(payload:EitherType<String, EitherType<Buffer, Dynamic>>, secretOrPrivateKey:Secret, ?options:SignOptions):String {})
	@:overload(function(payload:EitherType<String, EitherType<Buffer, Dynamic>>, secretOrPrivateKey:Secret, callback:SignCallback):Void {})
	static function sign(payload:EitherType<String, EitherType<Buffer, Dynamic>>, secretOrPrivateKey:Secret, options:SignOptions, callback:SignCallback):Void;

	@:overload(function(token:String, secretOrPublicKey:EitherType<String, Buffer>):EitherType<Dynamic, String> {})
	@:overload(function(token:String, secretOrPublicKey:EitherType<String, Buffer>, ?options:VerifyOptions):EitherType<Dynamic, String> {})
	@:overload(function(token:String, secretOrPublicKey:EitherType<String, Buffer>, ?callback:VerifyCallback):Void {})
	static function verify(token:String, secretOrPublicKey:EitherType<String, Buffer>, ?options:VerifyOptions, ?callback:VerifyCallback):Void;

	static function decode(token:String, ?options:DecodeOptions):EitherType<Null, haxe.extern.EitherType<{ }, String>>;

}


extern class JsonWebTokenError extends Error {
	var inner : Error;
	function new(message:String, ?error:Error):Void;
}
extern class TokenExpiredError extends JsonWebTokenError {
	var expiredAt : Int;
	function new(message:String, expiredAt:Int):Void;
}
extern class NotBeforeError extends JsonWebTokenError {
	var date : Date;
	function new(message:String, date:Date):Void;
}

typedef Secret = {
}


typedef SignOptions = {
	@:optional
	var algorithm : String;
	@:optional
	var keyid : String;
	@:optional
	var expiresIn : haxe.extern.EitherType<String, Int>;
	@:optional
	var notBefore : haxe.extern.EitherType<String, Int>;
	@:optional
	var audience : haxe.extern.EitherType<String, Array<String>>;
	@:optional
	var subject : String;
	@:optional
	var issuer : String;
	@:optional
	var jwtid : String;
	@:optional
	var noTimestamp : Bool;
	@:optional
	var header : Dynamic;
	@:optional
	var encoding : String;
};
typedef VerifyOptions = {
	@:optional
	var algorithms : Array<String>;
	@:optional
	var audience : haxe.extern.EitherType<String, Array<String>>;
	@:optional
	var clockTimestamp : Int;
	@:optional
	var clockTolerance : Int;
	@:optional
	var issuer : haxe.extern.EitherType<String, Array<String>>;
	@:optional
	var ignoreExpiration : Bool;
	@:optional
	var ignoreNotBefore : Bool;
	@:optional
	var jwtid : String;
	@:optional
	var subject : String;
	@:optional
	var maxAge : String;
};
typedef DecodeOptions = {
	@:optional
	var complete : Bool;
	@:optional
	var json : Bool;
};
typedef VerifyCallback = { };
typedef SignCallback = { };
