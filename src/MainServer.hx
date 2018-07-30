package ;

import js.Node;
import js.node.Http;
import js.node.Path;
import js.Node.console;

import js.npm.Express;
import js.npm.express.*;
// import js.npm.

import config.Config;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class MainServer {

	var config : Config = new Config();

	function new() {

		// trace(Test.template('mtt'));

		var isDev = config.ENVIRONMENT == 'development';
		console.log('isDev: ${isDev}');

		// start server
		var app : Express = new Express();

		// Don't touch this if you don't know it
		// We are using this for the express-rate-limit middleware
		// See: https://github.com/nfriedly/express-rate-limit
		// app.enable('trust proxy');

		// Set public folder using built-in express.static middleware
		app.use(new Static(Path.join(Node.__dirname, 'public')));

		// Set body parser middleware
		app.use(BodyParser.json());
		app.use(BodyParser.urlencoded({ extended: true }));

		app.use(new Morgan('dev'));

		// Enable cross-origin access through the CORS middleware
		// NOTICE: For React development server only!
		// if (process.env.CORS) {
		//   app.use(cors());
		// }

		// all environments
		app.set('port', config.PORT);
		app.set('views', Node.__dirname + '/public/');
		// trace(app.get('views'));

		// Templating

		// Haxe templating
		app.engine('mtt', template.Mtt.engine);
		app.set('views', [app.get('views') , (Node.__dirname + '/views/mtt')]); // specify the views directory (add old one first)
		trace(app.get('views'));
		app.set('view engine', 'mtt'); // register the template engine
		app.get('/mtt', function (req:Request,res:Response) {
			res.render('_index',{title:'Home'});
		});


		// Jade templating
		// app.set('view engine', 'jade');

		/*
		// Swig templating
		app.engine('html', swig.renderFile);
		app.set('view engine', 'html');
		app.set('views', path.resolve(__dirname , '../views'));
		// Swig will cache templates for you, but you can disable
		// that and use Express's caching instead, if you like:
		app.set('view cache', !isDev); // false
		// To disable Swig's cache, do the following:
		// console.log((isDev) ? false : 'memory');
		// swig.setDefaults({ cache: false  }); // false
		swig.setDefaults({ cache: (isDev) ? false : 'memory' }); // false
		// NOTE: You should always cache templates in a production environment.
		// Don't leave both of these to `false` in production!

		// create a global value `_ext.{whatever}`
		swig.setExtension('isDev', isDev );     // `_ext.isDev` you can use to show/hide stuff in developers mode
		swig.setExtension('now', new Date() );  // `_ext.now` is the current date
		*/

		// Routes
		app.get('/', function (req:Request,res:Response) {
			res.sendFile(Node.__dirname + '/public/index.html');
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