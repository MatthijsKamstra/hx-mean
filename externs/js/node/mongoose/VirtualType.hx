package externs.js.node.mongoose;

import haxe.Constraints.Function;
import haxe.extern.EitherType;

typedef VirtualTypeObj = {
	@:optional var ref:EitherType<String, Function>; //] «string|function» if ref is not nullish, this becomes a populated virtual
	@:optional var localField:EitherType<String, Function>; //] «string|function» the local field to populate on if this is a populated virtual.
	@:optional var foreignField:EitherType<String, Function>; //] «string|function» the foreign field to populate on if this is a populated virtual.
	@:optional var justOne:Bool; //=false] «boolean» by default, a populated virtual is an array. If you set justOne, the populated virtual will be a single doc or null.
	@:optional var getters:Bool; //=false] «boolean» if you set this to true, Mongoose will call any custom getters you defined on this virtual
};

/**
 * Haxe externs for mongoose.js v5.2.9
 * Project: https://mongoosejs.com/
 * Definitions by:	wiggin77 <https://github.com/wiggin77>
 * 					Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions: 	<https://github.com/wiggin77/HxMongoNode> (2.0)
 * 					<https://github.com/matthijskamstra/hx-mean>
 */
@:jsRequire("mongoose", "VirtualType")
extern class VirtualType
{
	/**
	 * This is what mongoose uses to define virtual attributes via `Schema.prototype.virtual`.
	 *
	 * @url		https://mongoosejs.com/docs/api.html#virtualtype_VirtualType
	 * @example
	 * 		const fullname = schema.virtual('fullname');
	 *		fullname instanceof mongoose.VirtualType // true
	 *
	 *
	 * @param options
	 */
	@:overload(function(str:String) :Void{})
	public function new(options:VirtualTypeObj);


	// VirtualType.prototype._applyDefaultGetters()
	// Parameters
	// fn «Function»
	// Returns:
	// «VirtualType» this
	// If no getters/getters, add a default
	/**
	 * [Description]
	 * @param fn
	 * @return VirtualType
	 */
	public function _applyDefaultGetters(fn: Function): VirtualType;



	// VirtualType.prototype.applyGetters()
	// Parameters
	// value «Object»
	// scope «Object»
	// Returns:
	// «any» the value after applying all getters
	// Applies getters to value using optional scope.
	/**
	 * [Description]
	 * @param value
	 * @param scope
	 * @return Dynamic
	 */
	public function applyGetters(value:Dynamic, scope:Dynamic):Dynamic;

	// VirtualType.prototype.applySetters()
	// Parameters
	// value «Object»
	// scope «Object»
	// Returns:
	// «any» the value after applying all setters
	// Applies setters to value using optional scope.
	/**
	 * [Description]
	 * @param value
	 * @param scope
	 * @return Dynamic
	 */
	public function applySetters(value:Dynamic, scope:Dynamic):Dynamic;


	/**
	 * Defines a getter.
	 *
	// Example:
	// var virtual = schema.virtual('fullname');
	// virtual.get(function () {
	//   return this.name.first + ' ' + this.name.last;
	// });
	 *
	 * @param fn
	 * @return VirtualType
	 */
	public function get (fn: Function):VirtualType;

	/**
	 *
	 * Defines a setter.
	 *
	// Example:
	// var virtual = schema.virtual('fullname');
	// virtual.set(function (v) {
	//   var parts = v.split(' ');
	//   this.name.first = parts[0];
	//   this.name.last = parts[1];
	// });
	 *
	 * @param fn
	 * @return VirtualType
	 */
	public function set (fn: Function):VirtualType;


}


