package externs.js.npm;

import haxe.extern.EitherType;
import haxe.Constraints.Function;

// TODO
typedef AlphaLocale = {}
typedef AlphanumericLocale = {}
typedef HashAlgorithm = {}
typedef MobilePhoneLocale = {}
typedef PostalCodeLocale ={}
typedef DecimalLocale ={}
typedef FloatLocale ={}

typedef ValidatorStatic = {
	function contains(str:String, elem:Dynamic):Bool;
	function equals(str:String, comparison:String):Bool;
	function isAfter(str:String, ?date:String):Bool;
	function isAlpha(str:String, ?locale:AlphaLocale):Bool;
	function isAlphanumeric(str:String, ?locale:AlphanumericLocale):Bool;
	function isAscii(str:String):Bool;
	function isBase64(str:String):Bool;
	function isBefore(str:String, ?date:String):Bool;
	function isBoolean(str:String):Bool;
	@:overload(function(str:String, min:Float, ?max:Float):Bool { })
	function isByteLength(str:String, options:IsByteLengthOptions):Bool;
	function isCreditCard(str:String):Bool;
	function isCurrency(str:String, ?options:IsCurrencyOptions):Bool;
	function isDataURI(str:String):Bool;
	function isDecimal(str:String, ?options:IsDecimalOptions):Bool;
	function isDivisibleBy(str:String, number:Float):Bool;
	function isEmail(str:String, ?options:IsEmailOptions):Bool;
	function isEmpty(str:String):Bool;
	function isFQDN(str:String, ?options:IsFQDNOptions):Bool;
	function isFloat(str:String, ?options:IsFloatOptions):Bool;
	function isFullWidth(str:String):Bool;
	function isHalfWidth(str:String):Bool;
	function isHash(str:String, algorithm:HashAlgorithm):Bool;
	function isHexColor(str:String):Bool;
	function isHexadecimal(str:String):Bool;
	function isIP(str:String, ?version:Float):Bool;
	function isISBN(str:String, ?version:Float):Bool;
	function isISSN(str:String, ?options:IsISSNOptions):Bool;
	function isISIN(str:String):Bool;
	function isISO8601(str:String):Bool;
	function isISO31661Alpha2(str:String):Bool;
	function isISRC(str:String):Bool;
	function isIn(str:String, values:Array<Dynamic>):Bool;
	function isInt(str:String, ?options:IsIntOptions):Bool;
	function isJSON(str:String):Bool;
	function isLatLong(str:String):Bool;
	@:overload(function(str:String, min:Float, ?max:Float):Bool { })
	function isLength(str:String, options:IsLengthOptions):Bool;
	function isLowercase(str:String):Bool;
	function isMACAddress(str:String):Bool;
	function isMD5(str:String):Bool;
	function isMimeType(str:String):Bool;
	function isMobilePhone(str:String, locale:MobilePhoneLocale, ?options:IsMobilePhoneOptions):Bool;
	function isMongoId(str:String):Bool;
	function isMultibyte(str:String):Bool;
	function isNumeric(str:String):Bool;
	function isPort(str:String):Bool;
	function isPostalCode(str:String, locale:PostalCodeLocale):Bool;
	function isSurrogatePair(str:String):Bool;
	function isURL(str:String, ?options:IsURLOptions):Bool;
	function isUUID(str:String, ?version:haxe.extern.EitherType<Int, haxe.extern.EitherType<Int, haxe.extern.EitherType<String, haxe.extern.EitherType<String, haxe.extern.EitherType<String, String>>>>>):Bool;
	function isUppercase(str:String):Bool;
	function isVariableWidth(str:String):Bool;
	function isWhitelisted(str:String, chars:haxe.extern.EitherType<String, Array<String>>):Bool;
	function matches(str:String, pattern:haxe.extern.EitherType<js.RegExp, String>, ?modifiers:String):Bool;
	function blacklist(input:String, chars:String):String;
	function escape(input:String):String;
	function unescape(input:String):String;
	function ltrim(input:String, ?chars:String):String;
	function normalizeEmail(email:String, ?options:NormalizeEmailOptions):haxe.extern.EitherType<String, Bool>;
	function rtrim(input:String, ?chars:String):String;
	function stripLow(input:String, ?keep_new_lines:Bool):String;
	function toBoolean(input:String, ?strict:Bool):Bool;
	function toDate(input:String):Date;
	function toFloat(input:String):Float;
	function toInt(input:String, ?radix:Float):Float;
	function trim(input:String, ?chars:String):String;
	function whitelist(input:String, chars:String):String;
	function toString(input:haxe.extern.EitherType<Dynamic, Array<Dynamic>>):String;
	var version : String;
	function extend<T:(haxe.Constraints.Function)>(name:String, fn:T):Void;
};
typedef IsByteLengthOptions = {
	@:optional
	var min : Float;
	@:optional
	var max : Float;
};
typedef IsCurrencyOptions = {
	@:optional
	var symbol : String;
	@:optional
	var require_symbol : Bool;
	@:optional
	var allow_space_after_symbol : Bool;
	@:optional
	var symbol_after_digits : Bool;
	@:optional
	var allow_negatives : Bool;
	@:optional
	var parens_for_negatives : Bool;
	@:optional
	var negative_sign_before_digits : Bool;
	@:optional
	var negative_sign_after_digits : Bool;
	@:optional
	var allow_negative_sign_placeholder : Bool;
	@:optional
	var thousands_separator : String;
	@:optional
	var decimal_separator : String;
	@:optional
	var allow_decimal : Bool;
	@:optional
	var require_decimal : Bool;
	@:optional
	var digits_after_decimal : Array<Float>;
	@:optional
	var allow_space_after_digits : Bool;
};
typedef IsDecimalOptions = {
	@:optional
	var force_decimal : Bool;
	@:optional
	var decimal_digits : String;
	@:optional
	var locale : DecimalLocale;
};
typedef IsEmailOptions = {
	@:optional
	var allow_display_name : Bool;
	@:optional
	var require_display_name : Bool;
	@:optional
	var allow_utf8_local_part : Bool;
	@:optional
	var require_tld : Bool;
};
typedef IsFQDNOptions = {
	@:optional
	var require_tld : Bool;
	@:optional
	var allow_underscores : Bool;
	@:optional
	var allow_trailing_dot : Bool;
};
typedef IsFloatOptions = {
	@:optional
	var min : Float;
	@:optional
	var max : Float;
	@:optional
	var gt : Float;
	@:optional
	var lt : Float;
	@:optional
	var locale : FloatLocale;
};
typedef IsISSNOptions = {
	@:optional
	var case_sensitive : Bool;
	@:optional
	var require_hyphen : Bool;
};
typedef IsIntOptions = {
	@:optional
	var min : Float;
	@:optional
	var max : Float;
	@:optional
	var allow_leading_zeroes : Bool;
	@:optional
	var lt : Float;
	@:optional
	var gt : Float;
};
typedef IsLengthOptions = {
	@:optional
	var min : Float;
	@:optional
	var max : Float;
};
typedef IsMobilePhoneOptions = {
	@:optional
	var strictMode : Bool;
};
typedef IsURLOptions = {
	@:optional
	var protocols : Array<String>;
	@:optional
	var require_tld : Bool;
	@:optional
	var require_protocol : Bool;
	@:optional
	var require_host : Bool;
	@:optional
	var require_valid_protocol : Bool;
	@:optional
	var allow_underscores : Bool;
	@:optional
	var host_whitelist : Array<haxe.extern.EitherType<String, js.RegExp>>;
	@:optional
	var host_blacklist : Array<haxe.extern.EitherType<String, js.RegExp>>;
	@:optional
	var allow_trailing_dot : Bool;
	@:optional
	var allow_protocol_relative_urls : Bool;
};
typedef NormalizeEmailOptions = {
	@:optional
	var all_lowercase : Bool;
	@:optional
	var gmail_lowercase : Bool;
	@:optional
	var gmail_remove_dots : Bool;
	@:optional
	var gmail_remove_subaddress : Bool;
	@:optional
	var gmail_convert_googlemaildotcom : Bool;
	@:optional
	var outlookdotcom_lowercase : Bool;
	@:optional
	var outlookdotcom_remove_subaddress : Bool;
	@:optional
	var yahoo_lowercase : Bool;
	@:optional
	var yahoo_remove_subaddress : Bool;
	@:optional
	var icloud_lowercase : Bool;
	@:optional
	var icloud_remove_subaddress : Bool;
};
typedef IValidatorStatic = {
	>ValidatorJS.ValidatorStatic,
};
typedef IURLoptions = {
	>ValidatorJS.IsURLOptions,
};
typedef IFQDNoptions = {
	>ValidatorJS.IsFQDNOptions,
};
typedef IEmailoptions = {
	>ValidatorJS.NormalizeEmailOptions,
};

/**
 * Haxe externs for validator.js v10.7.0
 * Project: https://github.com/chriso/validator.js
 * Definitions by: 	Clément Charmet <https://github.com/clemos>
 *					Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions: <https://github.com/clemos/haxe-js-kit/>
 *    			<https://github.com/matthijskamstra/hx-mean>
 */
@:jsRequire("validator")
@:native('validator')
extern class ValidatorJS {

	// validator.isEmail('foo@bar.com'); //=> true
	public static function isEmail(str:String, ?options : IsEmailOptions ):Bool;

/*
declare module "validator" {
  export = validator;
}

declare module "validator/lib/blacklist" {
  const blacklist: typeof validator.blacklist;
  export = blacklist;
}

declare module "validator/lib/contains" {
  const contains: typeof validator.contains;
  export = contains;
}

declare module "validator/lib/equals" {
  const equals: typeof validator.equals;
  export = equals;
}

declare module "validator/lib/escape" {
  const escape: typeof validator.escape;
  export = escape;
}

declare module "validator/lib/isAfter" {
  const isAfter: typeof validator.isAfter;
  export = isAfter;
}

declare module "validator/lib/isAlpha" {
  const isAlpha: typeof validator.isAlpha;
  export = isAlpha;
}

declare module "validator/lib/isAlphanumeric" {
  const isAlphanumeric: typeof validator.isAlphanumeric;
  export = isAlphanumeric;
}

declare module "validator/lib/isAscii" {
  const isAscii: typeof validator.isAscii;
  export = isAscii;
}

declare module "validator/lib/isBase64" {
  const isBase64: typeof validator.isBase64;
  export = isBase64;
}

declare module "validator/lib/isBefore" {
  const isBefore: typeof validator.isBefore;
  export = isBefore;
}

declare module "validator/lib/isBoolean" {
  const isBoolean: typeof validator.isBoolean;
  export = isBoolean;
}

declare module "validator/lib/isByteLength" {
  const isByteLength: typeof validator.isByteLength;
  export = isByteLength;
}

declare module "validator/lib/isCreditCard" {
  const isCreditCard: typeof validator.isCreditCard;
  export = isCreditCard;
}

declare module "validator/lib/isCurrency" {
  const isCurrency: typeof validator.isCurrency;
  export = isCurrency;
}

declare module "validator/lib/isDataURI" {
  const isDataURI: typeof validator.isDataURI;
  export = isDataURI;
}

declare module "validator/lib/isDecimal" {
  const isDecimal: typeof validator.isDecimal;
  export = isDecimal;
}

declare module "validator/lib/isDivisibleBy" {
  const isDivisibleBy: typeof validator.isDivisibleBy;
  export = isDivisibleBy;
}

declare module "validator/lib/isEmail" {
  const isEmail: typeof validator.isEmail;
  export = isEmail;
}

declare module "validator/lib/isEmpty" {
  const isEmpty: typeof validator.isEmpty;
  export = isEmpty;
}

declare module "validator/lib/isFQDN" {
  const isFQDN: typeof validator.isFQDN;
  export = isFQDN;
}

declare module "validator/lib/isFloat" {
  const isFloat: typeof validator.isFloat;
  export = isFloat;
}

declare module "validator/lib/isFullWidth" {
  const isFullWidth: typeof validator.isFullWidth;
  export = isFullWidth;
}

declare module "validator/lib/isHalfWidth" {
  const isHalfWidth: typeof validator.isHalfWidth;
  export = isHalfWidth;
}

declare module "validator/lib/isHash" {
  const isHash: typeof validator.isHash;
  export = isHash;
}

declare module "validator/lib/isHexColor" {
  const isHexColor: typeof validator.isHexColor;
  export = isHexColor;
}

declare module "validator/lib/isHexadecimal" {
  const isHexadecimal: typeof validator.isHexadecimal;
  export = isHexadecimal;
}

declare module "validator/lib/isIP" {
  const isIP: typeof validator.isIP;
  export = isIP;
}

declare module "validator/lib/isISBN" {
  const isISBN: typeof validator.isISBN;
  export = isISBN;
}

declare module "validator/lib/isISSN" {
  const isISSN: typeof validator.isISSN;
  export = isISSN;
}

declare module "validator/lib/isISIN" {
  const isISIN: typeof validator.isISIN;
  export = isISIN;
}

declare module "validator/lib/isISO8601" {
  const isISO8601: typeof validator.isISO8601;
  export = isISO8601;
}

declare module "validator/lib/isISO31661Alpha2" {
  const isISO31661Alpha2: typeof validator.isISO31661Alpha2;
  export = isISO31661Alpha2;
}

declare module "validator/lib/isISRC" {
  const isISRC: typeof validator.isISRC;
  export = isISRC;
}

declare module "validator/lib/isIn" {
  const isIn: typeof validator.isIn;
  export = isIn;
}

declare module "validator/lib/isInt" {
  const isInt: typeof validator.isInt;
  export = isInt;
}

declare module "validator/lib/isJSON" {
  const isJSON: typeof validator.isJSON;
  export = isJSON;
}

declare module "validator/lib/isLatLong" {
  const isLatLong: typeof validator.isLatLong;
  export = isLatLong;
}

declare module "validator/lib/isLength" {
  const isLength: typeof validator.isLength;
  export = isLength;
}

declare module "validator/lib/isLowercase" {
  const isLowercase: typeof validator.isLowercase;
  export = isLowercase;
}

declare module "validator/lib/isMACAddress" {
  const isMACAddress: typeof validator.isMACAddress;
  export = isMACAddress;
}

declare module "validator/lib/isMD5" {
  const isMD5: typeof validator.isMD5;
  export = isMD5;
}

declare module "validator/lib/isMimeType" {
  const isMimeType: typeof validator.isMimeType;
  export = isMimeType;
}

declare module "validator/lib/isMobilePhone" {
  const isMobilePhone: typeof validator.isMobilePhone;
  export = isMobilePhone;
}

declare module "validator/lib/isPostalCode" {
  const isPostalCode: typeof validator.isPostalCode;
  export = isPostalCode;
}

declare module "validator/lib/isMongoId" {
  const isMongoId: typeof validator.isMongoId;
  export = isMongoId;
}

declare module "validator/lib/isMultibyte" {
  const isMultibyte: typeof validator.isMultibyte;
  export = isMultibyte;
}

declare module "validator/lib/isNumeric" {
  const isNumeric: typeof validator.isNumeric;
  export = isNumeric;
}

declare module "validator/lib/isPort" {
  const isPort: typeof validator.isPort;
  export = isPort;
}

declare module "validator/lib/isSurrogatePair" {
  const isSurrogatePair: typeof validator.isSurrogatePair;
  export = isSurrogatePair;
}

declare module "validator/lib/isURL" {
  const isURL: typeof validator.isURL;
  export = isURL;
}

declare module "validator/lib/isUUID" {
  const isUUID: typeof validator.isUUID;
  export = isUUID;
}

declare module "validator/lib/isUppercase" {
  const isUppercase: typeof validator.isUppercase;
  export = isUppercase;
}

declare module "validator/lib/isVariableWidth" {
  const isVariableWidth: typeof validator.isVariableWidth;
  export = isVariableWidth;
}

declare module "validator/lib/isWhitelisted" {
  const isWhitelisted: typeof validator.isWhitelisted;
  export = isWhitelisted;
}

declare module "validator/lib/ltrim" {
  const ltrim: typeof validator.ltrim;
  export = ltrim;
}

declare module "validator/lib/matches" {
  const matches: typeof validator.matches;
  export = matches;
}

declare module "validator/lib/normalizeEmail" {
  const normalizeEmail: typeof validator.normalizeEmail;
  export = normalizeEmail;
}

declare module "validator/lib/rtrim" {
  const rtrim: typeof validator.rtrim;
  export = rtrim;
}

declare module "validator/lib/stripLow" {
  const stripLow: typeof validator.stripLow;
  export = stripLow;
}

declare module "validator/lib/toBoolean" {
  const toBoolean: typeof validator.toBoolean;
  export = toBoolean;
}

declare module "validator/lib/toDate" {
  const toDate: typeof validator.toDate;
  export = toDate;
}

declare module "validator/lib/toFloat" {
  const toFloat: typeof validator.toFloat;
  export = toFloat;
}

declare module "validator/lib/toInt" {
  const toInt: typeof validator.toInt;
  export = toInt;
}

declare module "validator/lib/trim" {
  const trim: typeof validator.trim;
  export = trim;
}

declare module "validator/lib/unescape" {
  const unescape: typeof validator.unescape;
  export = unescape;
}

declare module "validator/lib/whitelist" {
  const whitelist: typeof validator.whitelist;
  export = whitelist;
}
*/

}

