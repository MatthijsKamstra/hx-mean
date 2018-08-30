package server.models;

import js.Node.console;

import externs.js.node.mongoose.Schema;
import externs.js.node.mongoose.Model;
import externs.js.node.mongoose.Mongoose;
import externs.js.npm.Bcrypt;
import externs.js.npm.ValidatorJS;

typedef UserObj = {
	username : String,
	email : String,
	passwordHash : String,
}

class User {

	var model : Model;
	var schema : Schema;
	var mongoose : Mongoose;

	public function new(){

		mongoose = MainServer.mongoose;

		schema = new Schema({
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
			}
		});

		schema.virtual('password').set(setPassword);
		schema.virtual('passwordConfirmation').set(setPasswordConfirmation);

		schema.path('passwordHash').validate(validatePasswordHash);
		schema.path('email').validate(validateEmail);

		// schema.methods.validatePassword = validatePassword; // looks old?
		schema.method('validatePassword', validatePassword);

		model = mongoose.model( 'User', schema );
		// trace(mongoose.version);
	}

	function setPassword(password) {
		console.log('setPassword - $password');
		js.Lib.nativeThis._password = password;
		js.Lib.nativeThis.passwordHash = Bcrypt.hashSync(password, Bcrypt.genSaltSync(8));
		console.log('${js.Lib.nativeThis._password} & ${js.Lib.nativeThis.passwordHash }');

	}
	function setPasswordConfirmation(passwordConfirmation) {
		js.Lib.nativeThis._passwordConfirmation = passwordConfirmation;
	}
	function validateEmail(email):Bool {
		if (!ValidatorJS.isEmail(email)) {
			return js.Lib.nativeThis.invalidate('email', 'A valid e-mail address is required.');
		} else {
			return true;
		}
	}

	function validatePassword(password) {
  		return Bcrypt.compareSync(password, js.Lib.nativeThis.passwordHash);
	}

	function validatePasswordHash():Bool{
		console.log(js.Lib.nativeThis);
		// if (js.Lib.nativeThis.isNew == true) {
		// 	if (!js.Lib.nativeThis._password) {
		// 		return js.Lib.nativeThis.invalidate('password', 'A password is required.');
		// 	}
		// 	if (js.Lib.nativeThis._password.length < 6) {
		// 		return js.Lib.nativeThis.invalidate('password', 'Password must be at least 6 characters.');
		// 	}
		// 	if (js.Lib.nativeThis._password !== js.Lib.nativeThis._passwordConfirmation) {
		// 		return js.Lib.nativeThis.invalidate('password', 'Passwords do not match.');
		// 	}
		// }
		return true;
	}



	public function add( obj : UserObj , callback : haxe.Constraints.Function ){
		// trace('ADD ( $obj)');
		model.create( obj , function(err,_created){
			trace(err);
			callback(_created);
			trace(_created);
		} );
	}

	public function create( obj : UserObj , callback : haxe.Constraints.Function ){
		trace('create ( $obj)');
		model.create( obj , function(err,_created){
			callback(_created);
			trace(_created);
		} );
	}

	public function count (callback : haxe.Constraints.Function ) {
		model.countDocuments({}, function (err, count){
			callback(count);
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
