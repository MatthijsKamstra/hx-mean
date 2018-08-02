package server;

import js.npm.Faker;

class DummyData {
	public function new(isDev:Bool = false) {
		Faker.locale = ("nl");

		var randomName = Faker.name.findName(); // Rowan Nikolaus
		var randomEmail = Faker.internet.email(); // Kassandra.Haley@erich.biz
		var randomCard = Faker.helpers.createCard(); // random contact card containing many properties

		// if(isDev) trace('$randomName , $randomEmail, ${haxe.Json.stringify(randomCard)}');

	}

	public function registerUsers(){
		trace('registerUsers');
	}
	public function trashCollection(){
		trace('trashCollection');
	}
}