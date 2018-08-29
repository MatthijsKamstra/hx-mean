package server;

import js.Node.console;

import server.models.RegisterUsers;

// Haxe externs
import js.npm.Faker;
import externs.js.node.mongoose.Schema;
import externs.js.node.mongoose.Model;
import externs.js.node.mongoose.Mongoose;


class DummyData {
	public function new(isDev:Bool = false) {
		Faker.locale = ("nl");

		var randomName = Faker.name.findName(); // Rowan Nikolaus
		var randomEmail = Faker.internet.email(); // Kassandra.Haley@erich.biz
		var randomCard = Faker.helpers.createCard(); // random contact card containing many properties

		// if(isDev) trace('$randomName , $randomEmail, ${haxe.Json.stringify(randomCard)}');
		if(isDev) trace('$randomName, $randomEmail');

	}

	public function registerUsers(mongoose:Mongoose){
		// trace('registerUsers');
		var r = new RegisterUsers(mongoose);
		r.count(function (count){
			// trace('>>> $count');
			if(count == 0) {
				for ( i in 0 ... 10 ) {
					var obj : RegisterUserObj = {
						uid : Faker.random.uuid(),
						street_number : Faker.random.number(),
						postal_code : Faker.address.zipCode(),
						ismember : Faker.random.boolean(),
					};
					r.add( obj, function (){
						trace('done');
					});
				}
			}
		});
		// trace( '/registerUsers'  );
	}

	public function trashCollection(){
		trace('trashCollection');
	}
}