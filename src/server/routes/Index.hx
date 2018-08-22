package server.routes;

import externs.js.npm.express.Request;
import externs.js.npm.express.Response;
import externs.js.npm.express.Router;

class Index {

	public var router:Router;

	public function new() {
		router = new Router();

		router.get('/', function(req:Request, res:Response) {
			res.end("Index");
		});
	}

}