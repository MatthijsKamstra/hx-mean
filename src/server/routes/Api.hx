package server.routes;

import externs.js.npm.express.Request;
import externs.js.npm.express.Response;
import externs.js.npm.express.Router;

class Api {

	public var router:Router;

	public function new() {
		router = new Router();

		router.get('/', function(req:Request, res:Response) {
			res.end("Api");
		});
		router.get('/test', function(req:Request, res:Response) {
			res.end("Api/test");
		});

		router.get('/superheros', function(req:Request, res:Response) {
			trace(untyped req.body.name);
			res.redirect('/api/test');
		});

		// read (one)
		router.get('/id/:id', function(req:Request, res:Response) {
			var id = untyped req.params.id;
			var json = { id : id, status:'ok'}
			res.json(json);
		});

		// CREATE
		router.post('/register', function(req:Request, res:Response) {
			// console.log(req);
			var json = haxe.Json.parse(haxe.Json.stringify(untyped req.body));
			trace('body: ', json);
			return res.status(500).json({ success: false, msg: 'hello' });

		});

		// DELETE
		router.delete('/:id', function(req:Request, res:Response) {
			var id = untyped req.params.id;
			var json = { id : id, status:'ok'}
			res.json(json);
		});

		// UPDATE
		router.put('/:id', function(req:Request, res:Response) {
			var id = untyped req.params.id;
			var json = { id : id, status:'ok'}
			res.json(json);
		});

		// read (all)
		router.get('/register/all', function(req:Request, res:Response) {
			var json = { total : 100, status:'ok'}
			res.json(json);
		});
	}

}
