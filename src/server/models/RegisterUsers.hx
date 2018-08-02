package server.models;

import js.npm.mongoose.Schema;


typedef RegisterUserObj = {
	uid : String,
	street_number : Int,
	postal_code : String
}

class RegisterUsers {

	var schema : Schema<RegisterUserObj>;
	var model : js.npm.mongoose.Model.Models<Dynamic>;

	public function new(){

		// var userObj : RegisterUserObj = {
		// 	uid : String,
		// 	street_number : Int,
		// 	postal_code : String
		// }

		schema = new Schema(RegisterUserObj);
		model = js.npm.Mongoose._.model( 'ChatLog', schema );
	}

	public function add( log : Dynamic , cb ){
		model.create( log , function(err,_created){
			cb();
		} );
	}

	public function history( cb ){
		model.find({})
			.sort('date')
			.exec(function(err,logs){

				if( err != null ){
					trace(err);
					cb([]);
				}
				cb(logs);
			});
	}

}
