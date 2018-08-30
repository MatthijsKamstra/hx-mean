package externs.js.npm;

/**
 * Haxe externs for Bcrypt v3.0.0
 * Project: https://github.com/kelektiv/node.bcrypt.js#api
 * Definitions by: 	Clément Charmet <https://github.com/clemos>
 *					Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions: <https://github.com/clemos/haxe-js-kit/>
 *    			<https://github.com/matthijskamstra/hx-mean>
 */
@:jsRequire('Bcrypt')
@:native('bcrypt')
extern class Bcrypt
// implements npm.Package.Require<"bcrypt","^3.0.0">
{

	// 3.0.0
	public static function genSaltSync(?rounds : Int, ?minor: Int) : String;

	// 3.0.0: todo cb
	public static function genSalt(?rounds : Int, ?minor: Int, ?cb : Dynamic) : Void;
	// haxe.Constraints.Function

	/**
	 * 3.0.0
	 * @example Bcrypt.hashSync(password, Bcrypt.genSaltSync(8));
	 */
	public static function hashSync(data : String, salt : String) : String;

	// 3.0.0: todo cb
	public static function hash(data : String, salt : String, ?cb : Dynamic) : Void;

	// 3.0.0
	public static function compareSync(data : String, encrypted : String) : Bool;

	// 3.0.0: todo cb
	public static function compare(data : String, encrypted : String, ?cb : Dynamic) : Void;

	// 3.0.0
	public static function getRounds(encrypted : String) : Int;
}