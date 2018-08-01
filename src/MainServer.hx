package ;

import js.Node;
import js.node.Http;
import js.node.Path;
import js.Node.console;

// externs
import js.npm.Express;
import js.npm.express.*;
import js.npm.Swig;
import js.npm.SocketIo;

import config.Config;
import server.routes.*;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class MainServer {

	var config : Config = new Config();

	// dummy template data
	var users = [{name:"Mark", age:30}, {name:"John", age:45}, {name:"Leo", age: 100}];

	function new() {

		// trace(Test.template('mtt'));

		var isDev = config.ENVIRONMENT == 'development';
		console.log('isDev: ${isDev}');

		// start server
		var app : Express 	= new Express();
		// var server 			= js.node.Http.createServer( cast app );
		// var io     			= new js.npm.socketio.Server(server);

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
		/*
		app.engine('mtt', template.Mtt.engine);
		app.set('views', [app.get('views') , (Node.__dirname + '/views/mtt')]); // specify the views directory (add old one first)
		trace(app.get('views'));
		app.set('view engine', 'mtt'); // register the template engine
		app.get('/mtt', function (req:Request,res:Response) {
			res.render('_index', { title:'Home', users:users });
		});
		*/

		// Jade templating
		// app.set('view engine', 'jade');
		// app.get('/jade', function (req:Request,res:Response) {
		// 	res.render('index',{title:'Home',h1:'Title'});
		// });


		// Swig templating

		app.engine('html', Swig.renderFile);
		app.set('view engine', 'html');
		// app.set('views', Path.resolve(Node.__dirname , '/views/swig'));
		app.set('views', (Node.__dirname  + '/views/swig'));
		// Swig will cache templates for you, but you can disable
		// that and use Express's caching instead, if you like:
		app.set('view cache', !isDev); // false
		// To disable Swig's cache, do the following:
		// console.log((isDev) ? false : 'memory');
		Swig.setDefaults({ cache: false  }); // false
		// Swig.setDefaults({ cache: (isDev) ? false : 'memory' }); // false
		// NOTE: You should always cache templates in a production environment.
		// Don't leave both of these to `false` in production!

		// create a global value `_ext.{whatever}`
		Swig.setExtension('isDev', isDev );     // `_ext.isDev` you can use to show/hide stuff in developers mode
		Swig.setExtension('now', Date.now() );  // `_ext.now` is the current date

		app.get('/swig', function (req:Request,res:Response) {
			res.render('_index', {
				title:'Template Example Swig',
				users:users
			});
		});


		// Initialize routes middleware
		app.use('/index', new Index().router);
		app.use('/api', new Api().router);
		app.use('/endpoint', new Endpoint().router);
		app.use('/users', new Users().router);


		// Routes
		app.get('/', function (req:Request,res:Response) {
			res.sendFile(Node.__dirname + '/public/index.html');
		});

		app.get('/remote', function (req:Request,res:Response) {
			res.sendFile(Node.__dirname + '/public/remote.html');
		});

		/**
		 * repeating visual test should be done here
		 */
		app.get('/test', function (req:Request,res:Response) {
			// res.sendFile( path.resolve(__dirname , '../public/test.html'));
			res.render('_test' , {
				title:"Test"
			});
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

		var server = app.listen(config.PORT, function(){
			// trace('Express server listening on port ' + app.get('port'));
			console.info('>>> 🌎 Open http://localhost:${config.PORT}/ in your browser.');
		});

		// Set up socket.io
		var io = js.npm.SocketIo.listen(server);
		var online = 0;

		io.on('connection', function (socket) {

			// trace('connect');

			socket.emit('message', { message: 'welcome to the chat' });
			socket.on('send', function (data) {
				io.sockets.emit('message', data);
			});

			online++;
			console.log('Socket ${socket.id} connected.');
			console.log('Online: ${online}');
			io.emit('visitor enters', online);

			// socket.on('add', data => socket.broadcast.emit('add', data));
			// socket.on('update', data => socket.broadcast.emit('update', data));
			// socket.on('delete', data => socket.broadcast.emit('delete', data));
			// socket.on('message', data => console.log( data ));

			socket.on('disconnect', function (socket) {
				online--;
				console.log('Socket ${socket.id} disconnected.');
				console.log('Online: ${online}');
				io.emit('visitor exits', online);
			});
		});

	}

	static public function main(){
		var main = new MainServer();
	}
}