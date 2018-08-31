package server.routes;

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

		router.get('/register', function(req:Request, res:Response) {
			var u = new User();
			if(!Reflect.hasField(req.body, 'user')) {
				var pass = Faker.random.word();
				Reflect.setField(req.body, 'user' ,{
					username: Faker.name.firstName(),
					email: Faker.internet.email(),
					password: pass,
					passwordConfirmation: pass,
				});
			}
			u.create(Reflect.getProperty(req.body,'user'), function (err, user) {
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

			// var user = {username:'Matthijs', email: 'matthijs@foo.bar', _id : 'ddasdgf425rsfdgwe56t'};

			// // var token = JsonWebToken.sign(user._id,  Config.SECRET, { expiresIn : (60*60*24) }); // invalid expiresIn option for string payload
			// // var token = JsonWebToken.sign(user._id,  Config.SECRET); // no expireIn date
			// var token = JsonWebToken.sign({user:user._id}, Config.SECRET, {
			// 	'expiresIn': (60*60*24)
			// });
			// return res.status(201).json({
			// 	message: 'Welcome ${user.username}!',
			// 	user:user,
			// 	token:token
			// });
			// res.end("users/register");
		});

		router.get('/login', function(req:Request, res:Response) {
			res.end("users/login");
		});
	}

}