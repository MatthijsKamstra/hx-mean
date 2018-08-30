package;

import js.node.Fs;

import js.Node;
import js.node.Path;
import js.Node.console;

import externs.js.node.mongoose.Schema;
import externs.js.node.mongoose.Mongoose;
import externs.js.npm.Bcrypt;

import config.Config;

class Test {



	public static var mongoose : Mongoose;

	public function new(arg) {
		// your code
	}

	public static function template(templateName:String) : String
	{
		switch (templateName) {
			case 'mtt':
				trace ('mtt');
				return Test.mtt();
			default : trace ("case '"+templateName+"': trace ('"+templateName+"');");
				return "xx";
		}


	}

	public static function mtt() : String
	{
		// hack Haxe because it uses dce and this disappears
		[].iterator();

		//
		var users : Array<Dynamic> = [{name:"Mark", age:30}, {name:"John", age:45}];
		var layout : String = Fs.readFileSync(Path.join(Node.__dirname, '/views/mtt/_layout.mtt'), 'utf8');
		var index : String = Fs.readFileSync(Path.join(Node.__dirname, '/views/mtt/_index.mtt'), 'utf8');

		var indexTemplate = new haxe.Template(index);
		var userOutput = indexTemplate.execute({users: users});

		// var userTemplate = new haxe.Template("::foreach users:: ::name::(::age::) ::end::");
		// var userOutput = userTemplate.execute({users: _users});


		var layoutTemplate = new haxe.Template(layout);
		var output = layoutTemplate.execute({
			content : userOutput,
			title : 'Haxe templating'
		});

		return output;
	}




	static function testMongoose(){
		var config : Config = new Config();
		// connect to the MongoDB
		var mongoConnect = config.MONGO_URL;
		if (config.MONGO_URL != '' && config.MONGO_USER != '' && config.MONGO_PASS != '') {
			mongoConnect = 'mongodb://${config.MONGO_USER}:${config.MONGO_PASS}@${config.MONGO_URL}';
		} else if (config.MONGO_URL != '') {
			mongoConnect = '${config.MONGO_URL}';
		}
		mongoConnect = 'mongodb://localhost/test';
		console.log(mongoConnect);


		mongoose = new Mongoose();
		// Use Node's default promise instead of Mongoose's promise library
		// untyped mongoose.Promise = untyped global.Promise;

		mongoose.connect(mongoConnect, {
			useNewUrlParser: true,
			// useMongoClient: true,
		});

		var db = mongoose.connection;
		db.on('error', function (err) {
			console.log('Database error: ${err}');
		});

		db.once('open', function() {
			console.log('Connected to the database "mongodb://${mongoose.connection.host}:${mongoose.connection.port}/${mongoose.connection.name}".');

			// var kittySchema = new Schema({
			// 	name: String,
			// 	age: untyped Number
			// });

			// var Kitten = mongoose.model('Kitten', kittySchema);

			// var silence = { name: 'Silence' };
			// console.log(silence.name); // 'Silence'


			// // fluffy.save(function (err, fluffy) {
			// // 	if (err) return console.error(err);
			// // 	fluffy.speak();
			// // });


			var kittySchema = new Schema({
				name: String,
				date: 'number'
			});

			var Kitten = mongoose.model('Kitten', kittySchema);

			var silence = untyped __js__ ('new Kitten({ name: \'Silence\' })');
			console.log(silence.name); // 'Silence'

			var fluffy = untyped __js__ ('new Kitten({ name: \'fluffy\' })');

			fluffy.save(function (err, fluffy) {
				if (err) return console.error(err);
				// fluffy.speak();
			});


			Kitten.create({ name: 'jelly beans', date: '133' }, function (err, _created){
				console.log(_created);
			});
		});

	}

	public static function bcrypt(){
		var password = 'ikbeneenpassword';
		var t = Bcrypt.hashSync(password, Bcrypt.genSaltSync(8));
		trace(t);
	}


}