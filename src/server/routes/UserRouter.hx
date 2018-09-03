package server.routes;

import js.Node.console;

import js.npm.Faker;
import externs.js.npm.express.Request;
import externs.js.npm.express.Response;
import externs.js.npm.express.Router;
import externs.js.npm.mw.Jwt;
import externs.js.npm.JsonWebToken;

import server.models.User;
import config.Config;

class UserRouter {

	public var router:Router;

	public function new() {
		router = new Router();

		router.get('/', function(req:Request, res:Response) {
			res.end("users");
		});

		// inputUserName=MatthijsKamstra&inputEmail=foo%40bar.nl&inputPassword=kiplekker!&inputPasswordConfirm=kiplekker!
		router.get ('/register', function(req:Request, res:Response) {
			res.end("users/register");
		});
		router.post('/register', function(req:Request, res:Response) {
			// res.end("users/register");
			trace(Reflect.getProperty(req.body, 'inputUserName'));
			trace(Reflect.getProperty(req.body, 'inputEmail'));
			trace(Reflect.getProperty(req.body, 'inputPassword'));
			trace(Reflect.getProperty(req.body, 'inputPasswordConfirm'));
			var user = {
				username: Reflect.getProperty(req.body, 'inputUserName'),
				email : Reflect.getProperty(req.body, 'inputEmail'),
				password: Reflect.getProperty(req.body, 'inputPassword'),
				passwordConfirmation : Reflect.getProperty(req.body, 'inputPasswordConfirm')
			}
			Reflect.setField(req.body, 'user', user);

			var u = new User();
			u.create(Reflect.getProperty(req.body,'user'), function (err, user) {
				// trace(err);
				// trace(user);
				if (err != null ) {
					return res.status(500).json({message: 'Something went wrong ($err).'});
				}
				var token = JsonWebToken.sign({user:user._id}, Config.SECRET, { expiresIn: 60*60*24 });
				return res.status(201).json({
					message: 'Welcome ${user.username}!',
					user:user,
					token:token
				});
			});
		});


		router.get('/signin', function(req:Request, res:Response) {
			res.end("users/signin");
		});
		router.post('/signin', function(req:Request, res:Response) {
			trace('/sigin');
			// console.log(req);
			// console.log(req.body);
			var u = new User();
			trace(Reflect.hasField(req.body, 'inputEmail'));
			trace(Reflect.getProperty(req.body, 'inputEmail'));
			// if(!Reflect.hasField(req.body, 'user')) {
			// 	var pass = Faker.random.word();
			// 	Reflect.setField(req.body, 'user' ,{
			// 		username: Faker.name.firstName(),
			// 		email: Faker.internet.email(),
			// 		password: pass,
			// 		passwordConfirmation: pass,
			// 	});
			// }

			var pEmail = Reflect.getProperty(req.body, 'inputEmail');
			var pPassword = Reflect.getProperty(req.body, 'inputPassword');

			u.findOne( {email: pEmail}, function (err, user) {
				if (err != null ) return res.status(500).json({ message: 'Something went wrong.'});
				if (user == null || untyped (!user.validatePassword(pPassword))) {
					return res.status(401).json({ message: 'Unauthorised.'});
				}
				var token = JsonWebToken.sign({user:untyped(user._id)}, Config.SECRET, { expiresIn: 60*60*24 });
				return res.status(200).json({
					message: 'Welcome back',
					user:user,
					token:token
				});
			});

			// res.end("users/signin");
		});
	}

}