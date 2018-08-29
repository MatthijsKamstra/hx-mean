package externs.js.npm.mw.cors;

import externs.js.npm.express.Request;
import haxe.extern.EitherType;
import js.Error;

/**
 * Haxe externs for express/cors v2.8.4
 * Project: https://github.com/expressjs/cors
 * Definitions by:  Franco Ponticelli <https://github.com/fponticelli>
 *                  Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions:     <https://github.com/abedev/hxexpress>
 *                  <https://github.com/matthijskamstra/hx-mean>
 */

/**
// The default configuration is the equivalent of:
	{
		"origin": "*",
		"methods": "GET,HEAD,PUT,PATCH,POST,DELETE",
		"preflightContinue": false,
		"optionsSuccessStatus": 204
	}
*/

/**
 * @url 	https://github.com/expressjs/cors#configuration-options
 *
 *	origin: Configures the Access-Control-Allow-Origin CORS header. Possible values:
 *		Boolean - set origin to true to reflect the request origin, as defined by req.header('Origin'), or set it to false to disable CORS.
 *		String - set origin to a specific origin. For example if you set it to "http://example.com" only requests from "http://example.com" will be allowed.
 *		RegExp - set origin to a regular expression pattern which will be used to test the request origin. If it's a match, the request origin will be reflected. For example the pattern /example\.com$/ will reflect any request that is coming from an origin ending with "example.com".
 *		Array - set origin to an array of valid origins. Each origin can be a String or a RegExp. For example ["http://example1.com", /\.example2\.com$/] will accept any request from "http://example1.com" or from a subdomain of "example2.com".
 *		Function - set origin to a function implementing some custom logic. The function takes the request origin as the first parameter and a callback (which expects the signature err [object], allow [bool]) as the second.
 *	methods: Configures the Access-Control-Allow-Methods CORS header. Expects a comma-delimited string (ex: 'GET,PUT,POST') or an array (ex: ['GET', 'PUT', 'POST']).
 *	allowedHeaders: Configures the Access-Control-Allow-Headers CORS header. Expects a comma-delimited string (ex: 'Content-Type,Authorization') or an array (ex: ['Content-Type', 'Authorization']). If not specified, defaults to reflecting the headers specified in the request's Access-Control-Request-Headers header.
 *	exposedHeaders: Configures the Access-Control-Expose-Headers CORS header. Expects a comma-delimited string (ex: 'Content-Range,X-Content-Range') or an array (ex: ['Content-Range', 'X-Content-Range']). If not specified, no custom headers are exposed.
 *	credentials: Configures the Access-Control-Allow-Credentials CORS header. Set to true to pass the header, otherwise it is omitted.
 *	maxAge: Configures the Access-Control-Max-Age CORS header. Set to an integer to pass the header, otherwise it is omitted.
 *	preflightContinue: Pass the CORS preflight response to the next handler.
 *	optionsSuccessStatus: Provides a status code to use for successful OPTIONS requests, since some legacy browsers (IE11, various SmartTVs) choke on 204.
 */
typedef Options = {
	?origin : EitherType<Bool, EitherType<String, OriginFunction>>,
	?methods : EitherType<String, Array<String>>,
	?allowedHeaders : EitherType<String, Array<String>>,
	?exposedHeaders : EitherType<String, Array<String>>,
	?credentials : Bool,
	?maxAge : Int,
	?preflightContinue : Dynamic,
	?optionsSuccessStatus : Int
}

typedef OriginFunction = String -> (Error -> Bool -> Void) -> Void;