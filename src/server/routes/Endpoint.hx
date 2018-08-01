package server.routes;

import js.npm.express.Request;
import js.npm.express.Response;
import js.npm.express.Router;

class Endpoint {

	public var router:Router;

	public function new() {
		router = new Router();

		router.get('/', function(req:Request, res:Response) {
			res.end("Endpoint");
		});
	}

}
