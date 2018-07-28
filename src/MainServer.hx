package ;

import js.Node;
import js.node.Http;
import js.node.Path;
import js.Node.console;

import js.npm.Express;
import js.npm.express.*;

import config.Config;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class MainServer {

	var config : Config = new Config();

	function new() {

		var isDev = config.ENVIRONMENT == 'development';
		console.log('isDev: ${isDev}');

		// start server
		var app : Express   = new Express();

		// Don't touch this if you don't know it
		// We are using this for the express-rate-limit middleware
		// See: https://github.com/nfriedly/express-rate-limit
		// app.enable('trust proxy');

		// Set public folder using built-in express.static middleware
		app.use(new Static(Path.join(Node.__dirname, 'public')));

		// Set body parser middleware
		app.use(BodyParser.json());
		app.use(BodyParser.urlencoded({ extended: true }));

		// Enable cross-origin access through the CORS middleware
		// NOTICE: For React development server only!
		// if (process.env.CORS) {
		//   app.use(cors());
		// }

		// all environments
		app.set('port', config.PORT);
		app.set('views', Node.__dirname + '/public/views');
		// app.set('view engine', 'jade');
		app.use(new Morgan('dev'));

		//Routes
		app.get('/', function (req:Request,res:Response) {
			res.sendFile(Node.__dirname + '/public/index_advanced.html');
		});

		app.get('/remote', function (req:Request,res:Response) {
			res.sendFile(Node.__dirname + '/public/remote_intermediate.html');
		});

		app.get('/jade', function (req:Request,res:Response) {
			res.render('index',{title:'Home',h1:'Title'});
		});

		// http://localhost:3000/api/users?username=foobar
		// routes will go here
		app.get('/api/users', function(req, res) {
			var username = req.param('username');
			res.send('username: ' + username );
		});

		// POST http://localhost:8080/api/users
		// app.post('/api/users', function (req, res) {
		// 	var _req : Dynamic = req;
		// 	var _username = _req.body.username;
		// 	res.send('_username: ' + _username);
		// });


		// var sample = "My name is <strong>::name::</strong>, <em>::age::</em> years old";
		// var user = {name:"Mark", age:30};
		// var template = new haxe.Template(sample);
		// var output = template.execute(user);
		// trace(output);


		// app.use(function(req, res, next) {
		// 	res.status(404).send('404');
		// 	// res.status(404).send(output);
		// });

		app.use(function (req:Request,res:Response, next) {
			res.sendFile( Path.resolve(Node.__dirname , 'public/400.html'));
		});

		app.use(function (err, req, res, next) {
			res.sendFile( Path.resolve(Node.__dirname , 'public/500.html'));
		});


		app.listen(config.PORT, function(){
			// trace('Express server listening on port ' + app.get('port'));
			console.info('>>> 🌎 Open http://localhost:${config.PORT}/ in your browser.');

		});


	}

	static public function main(){
		var main = new MainServer();
	}
}