package config;

import js.Node.*;

class Config {

	//  default environment vars.
	public var ENVIRONMENT : String;
	public var PORT : Int;
	public var MONGO_URL : String;
	public var MONGO_USER : String;
	public var MONGO_PASS : String;

  	// extra variables
	public var API_KEY : String;

	public function new () {
		ENVIRONMENT 	= process.env.exists("ENVIRONMENT") 	? process.env["ENVIRONMENT"]		: 'development';
		PORT 			= process.env.exists("PORT") 			? Std.parseInt(process.env["PORT"]) : 8000;
		MONGO_URL 		= process.env.exists('MONGO_URL') 		? process.env['MONGO_URL'] 			: 'mongodb://localhost:27017/hxmean';
		MONGO_USER 		= process.env.exists('MONGO_USER') 		? process.env['MONGO_USER'] 		: '';
		MONGO_PASS 		= process.env.exists('MONGO_PASS') 		? process.env['MONGO_PASS'] 		: '';
	}
}