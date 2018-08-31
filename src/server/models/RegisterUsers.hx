package server.models;

import externs.js.node.mongoose.Schema;
import externs.js.node.mongoose.Model;
import externs.js.node.mongoose.Mongoose;
import externs.js.node.mongoose.Error;

import haxe.extern.EitherType;

typedef RegisterUserObj = {
	uid : String,
	street_number : Int,
	postal_code : String,
	ismember : Bool,
}

class RegisterUsers {

	var model : Model;
	var schema : Schema;
	var mongoose : Mongoose;

	public function new(){

		mongoose = MainServer.mongoose;

		schema = new Schema({
			uid : String,
			street_number : 'Number',
			postal_code : String,
			ismember : 'Boolean',
		});

		// [mck] prefend: "OverwriteModelError: Cannot overwrite `User` model once compiled."
		try {
			model = mongoose.model( 'RegisterUsers' );
		} catch (error:Dynamic) {
			model = mongoose.model( 'RegisterUsers', schema );
		}
		// trace(mongoose.version);	}
	}

	public function add( obj : RegisterUserObj ,  callback: EitherType <Dynamic, Error> ->  Dynamic -> Void ){
		// trace('ADD ( $obj)');
		model.create( obj , function(err,data){
			callback(err, data);
			// trace(data);
		} );
	}

	public function count (callback : haxe.Constraints.Function ) {
		model.countDocuments({}, function (err, count){
			callback(count);
		});
	}

	public function history( callback : haxe.Constraints.Function ){
		model.find({})
			.sort('date')
			.exec(function(err,logs){

				if( err != null ){
					trace(err);
					callback([]);
				}
				callback(logs);
			});
	}

}
