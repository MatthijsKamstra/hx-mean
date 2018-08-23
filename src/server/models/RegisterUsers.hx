package server.models;

import externs.js.node.mongoose.Schema;
import externs.js.node.mongoose.Model;
import externs.js.node.mongoose.Mongoose;

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

	public function new(?pMongoose:Mongoose){

		if (pMongoose == null) pMongoose = MainServer.mongoose;
		mongoose = pMongoose;

		schema = new Schema({
			uid : String,
			street_number : 'Number',
			postal_code : String,
			ismember : 'Boolean',
		});
		model = mongoose.model( 'RegisterUsers', schema );


		// trace(mongoose.version);

		// var obj : RegisterUserObj = {
		// 	uid : 'FOOBAR',
		// 	street_number : 1005472,
		// 	postal_code : '9999ZZ'
		// };
		// model.create( obj, function (err,_created){
		// 	trace(_created);
		// });

	}

	public function add( obj : RegisterUserObj , callback : haxe.Constraints.Function ){
		// trace('ADD ( $obj)');
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
