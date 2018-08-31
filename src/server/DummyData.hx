package server;

import js.Node.console;

import server.models.RegisterUsers;
import server.models.User;

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

	public function init(){
		registerUsers();
		user();
		trashCollection();
		chatLog();
	}

	public function user(){
		trace('users');
		var r = new User();
		r.count(function (err,count){
			// trace('>>> $count');
			if(count == 0) {
				var obj : UserObj = {
					username : 'matthijskamstra',
					email : 'matthijskamstra@gmail.com',
					password : "lekkergemeen123!",
					passwordConfirmation : 'lekkergemeen123!',
					role : 'admin',
				}
				r.add(obj,function (err, data){
					if (err != null ) {
						trace('err: $err)');
					}
					trace('added admin: $data');
				});
				for ( i in 0 ... 10 ) {
					var pass = Faker.random.words();
					var obj : UserObj = {
						username: Faker.name.firstName(),
						email: Faker.internet.email(),
						password: pass,
						passwordConfirmation: pass,
					};
					r.add( obj, function (err, data){
						if (err != null ) {
							trace('err: $err)');
						}
						trace('$i. user - done: $data');
					});
				}

			}
		});

	}
	public function chatLog(){
		trace('chatLog');

	}

	public function registerUsers(){
		trace('registerUsers');
		var r = new RegisterUsers();
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
					r.add( obj, function (err, data){
						if (err != null ) {
							trace('err: $err)');
						}
						trace('$i. registerUser - done: $data');
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