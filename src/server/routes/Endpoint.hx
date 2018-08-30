package server.routes;

import externs.js.npm.express.Request;
import externs.js.npm.express.Response;
import externs.js.npm.express.Router;

import js.npm.Faker;

class Endpoint {

	public var router:Router;

	public function new() {
		router = new Router();

		router.get('/', function(req:Request, res:Response) {
			res.end("Endpoint");
		});

		router.get('/test', function(req:Request, res:Response) {
			// var id = untyped req.params.id;
			// var json = { id : id, status:'ok'}
			var arr = [];
			var json = arr;
			for ( i in 0 ... 10 ) {
				var obj  = {
					uid : Faker.random.uuid(),
					card : Faker.helpers.createCard(),
				};
				arr.push(obj);
			}
			// [mck] make sure it's valid json file
			res.json( haxe.Json.parse(  haxe.Json.stringify( arr ) ) );
		});

		router.get('/superhero', function(req:Request, res:Response) {
			res.end("superhero");
		});

		router.get('/id/:id', function(req:Request, res:Response) {
			// var id = req.params.id; // Computer says NO! // { } has no field id
			// var id = untyped req.params.id;
			// var id = req.param('id'); // Deprecated
			var id = Reflect.getProperty(req.params,'id');
			var json = { id : id, status:'ok'}
			res.json(json);
		});


		// CRUD

		// | GET | Read |
		// | POST | Create |
		// | PUT | Update |
		// | DELETE | Delete |


	}

}
