package server.models;

import js.Node.console;

import externs.js.node.mongoose.Schema;
import externs.js.node.mongoose.Model;
import externs.js.node.mongoose.Mongoose;
import externs.js.node.mongoose.Error;
import externs.js.npm.Bcrypt;
import externs.js.npm.ValidatorJS;

import haxe.extern.EitherType;

typedef UserObj = {
	username : String,
	email : String,
	password : String,
	passwordConfirmation : String,
	?role : String,
}

class User {

	var model : Model;
	var userSchema : Schema;
	var mongoose : Mongoose;

	public function new(){

		mongoose = MainServer.mongoose;

		userSchema = new Schema({
			username: {
				type: String,
				unique: true,
				required: true
			},
			email: {
				type: String,
				unique: true,
				required: true
			},
			passwordHash: {
				type: String,
				unique: true,
				required: true
			},
			role: {
				type: String
			}
		});

		// userSchema.virtual('password').set(setPassword); // [mck] for some reason it losses scope
		userSchema.virtual('password').set(function (password){
			js.Lib.nativeThis._password = password;
			js.Lib.nativeThis.passwordHash = Bcrypt.hashSync(password, Bcrypt.genSaltSync(8));
		});

		// userSchema.virtual('passwordConfirmation').set(this.setPasswordConfirmation);
		userSchema.virtual('passwordConfirmation').set(function (passwordConfirmation) {
			js.Lib.nativeThis._passwordConfirmation = passwordConfirmation;
		});

		// userSchema.path('passwordHash').validate(validatePasswordHash);
		userSchema.path('passwordHash').validate(function ():Bool{
			if (js.Lib.nativeThis.isNew) {
				if (js.Lib.nativeThis._password == null) {
					return js.Lib.nativeThis.invalidate('password','A password is required.');
				}
				if (js.Lib.nativeThis._password.length < 6) {
					return js.Lib.nativeThis.invalidate('password','Password must be at least 6 characters.');
				}
				if (js.Lib.nativeThis._password != js.Lib.nativeThis._passwordConfirmation) {
					return js.Lib.nativeThis.invalidate('password','Passwords do not match.');
				}
				return true;
			} else {
				return false;
			}
		});

		// userSchema.path('email').validate(validateEmail);
		userSchema.path('email').validate(	function (email) {
			if (!ValidatorJS.isEmail(email)) {
				return js.Lib.nativeThis.invalidate('email', 'A valid e-mail address is required.');
			} else {
				return true;
			}
		});

		// userSchema.methods.validatePassword = validatePassword; // looks old?
		// userSchema.method('validatePassword', validatePassword);
		userSchema.method('validatePassword', 	function (password):Bool {
			return Bcrypt.compareSync(password, js.Lib.nativeThis.passwordHash);
		});

		// [mck] prefend: "OverwriteModelError: Cannot overwrite `User` model once compiled."
		try {
			model = mongoose.model( 'User' );
		} catch (error:Dynamic) {
			model = mongoose.model( 'User', userSchema );
		}

		// trace(mongoose.version);
	}

	public function add( obj : UserObj , callback: EitherType <Dynamic, Error> ->  Dynamic -> Void ){
		trace('ADD ( $obj)');
		model.create( obj , function(err,data){
			callback(err,data);
		} );
	}

	public function create( obj : UserObj , callback: EitherType <Dynamic, Error> ->  Dynamic -> Void ){
		// trace('create ( $obj)');
		model.create( obj , function(err,data){
			callback(err, data);
		} );
	}

	public function count (callback: EitherType <Dynamic, Error> ->  Dynamic -> Void ){
		model.countDocuments({}, function (err, count){
			callback(err, count);
		});
	}

	// public function history( callback : haxe.Constraints.Function ){
	// 	model.find({})
	// 		.sort('date')
	// 		.exec(function(err,logs){

	// 			if( err != null ){
	// 				trace(err);
	// 				callback([]);
	// 			}
	// 			callback(logs);
	// 		});
	// }

}
