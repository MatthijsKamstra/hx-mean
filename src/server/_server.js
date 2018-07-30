const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const morgan = require('morgan');
// const cors = require('cors');
const mongoose = require('mongoose');
const socket = require('socket.io');
const swig = require('swig-templates');
const fs = require('fs');

// Import required modules
var dummyData = require ('./dummyData');

// Import models
const RegisterUser = require('./models/registeruser');
const TrashCollection = require('./models/trashcollection');

// use .env or the config!
const config = require('../config/config');
console.log(`config: `);
console.log(config);

var isDev = config.environment === 'development';
console.log(`isDev: ${isDev}`);

// get shoppinglist from json file
var shoppinglist =  JSON.parse( fs.readFileSync( path.resolve(__dirname , '../public/data/shoppinglist.json')) );
// console.log(shoppinglist);

// connect to the MongoDB
let mongoConnect = config.mongoURL;
if (config.mongoURL !== '' && config.mongoUser !== '' && config.mongoPass != '') {
  mongoConnect = `mongodb://${config.mongoUser}:${config.mongoPass}@${config.mongoURL}`;
} else if (config.mongoURL !== '') {
  mongoConnect = `${config.mongoURL}`;
}
console.log(mongoConnect);

// Use Node's default promise instead of Mongoose's promise library
mongoose.Promise = global.Promise;

mongoose.connect(mongoConnect, { useNewUrlParser: true })
  .catch((err) => {
    if (err) {
      console.error(err);
    }
  }
);

var db = mongoose.connection;
db.on('open', () => {
  console.log(`Connected to the database "${mongoConnect}".`);
  // feed some dummy data in DB.
  if (isDev) dummyData.registerUsers();
  if (isDev) dummyData.trashCollection();
});

db.on('error', (err) => {
  console.log(`Database error: ${err}`);
});

// Instantiate express
const app = express();

// Don't touch this if you don't know it
// We are using this for the express-rate-limit middleware
// See: https://github.com/nfriedly/express-rate-limit
// app.enable('trust proxy');

// Set public folder using built-in express.static middleware
app.use(express.static( path.resolve(__dirname , '../public/')));

// Set body parser middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Enable cross-origin access through the CORS middleware
// NOTICE: For React development server only!
// if (process.env.CORS) {
//   app.use(cors());
// }

// This is where all the magic happens! swig
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

// Initialize routes middleware
var api = require('./routes/api');
app.use('/api', api);
// app.use('/endpoint', require('./routes/endpoint'));

// show homepage
app.get('/', function (req,res) {
	// res.sendFile( path.resolve(__dirname , '../public/index.html'));

  // [mck] not sure this is the best solution, but for now it will doe
  TrashCollection.find({} , function (err, trashresult) {
    // console.log('err: ' , err, 'trashresult: ' , trashresult);
    if (err) {
      trashresult = {};
    }
    RegisterUser.find({} , function (err, userresult) {
      // console.log('err: ' , err, 'userresult: ' , userresult);
      if (err) {
        userresult = {};
      }
      res.render('_homepage' , {
        title:"Homepage",
        trashresult:trashresult,
        userresult:userresult,
        shoppinglist:shoppinglist
      });
    });
  });
});

/**
 * this is the place that needs to check very thoroughly,
 * is the uid is valid AND the teacher is done correctly
 *
 * most of the different versions should be done in `view/_test.html` / `/test`
 */
app.get('/start', function (req,res) {
	// res.sendFile( path.resolve(__dirname , '../public/editor.html'));
  // console.log(req);
  // console.log(req.query);
  // console.log(req.query.isteacher);

  var uid = (req.query.uid) ? req.query.uid : '';
  var isteacher = false;
  isteacher = (req.query.isteacher === undefined || req.query.isteacher === '') ? false : (req.query.isteacher === 'true');

  // console.log('isteacher: ' + isteacher);
  // console.log(!isteacher);
  // console.log(isteacher == true);
  // console.log(isteacher == false);

  if(isteacher == false){
    // student will be redirected to a exit page
    console.log('this should work');
    res.redirect(`/student`);
    return;
  }
  // TODO : [mck] check if user exist, otherwise redirect to score/shoppingList, otherwise continue here
  // var uid = 'f9edb5a5-4792-4dc1-9347-57def8b4d402'; //
  console.log ('uid:' , uid);
  RegisterUser.findOne({'uid': uid} , function (err, result) {
    // console.log('err: ' , err, 'result: ' , result);
    if (err) {
      return;
    }
    if(result){

      console.log(result);

      console.log('bestaat WEL, redirect');
      // res.redirect(`/score?uid=${uid}&isteacher=${isteacher}`);
      res.redirect(`/editor?uid=${uid}&isteacher=${isteacher}`);
    } else {
      console.log('bestaat niet');
      // res.redirect('/test');

      // [mck] just use this address for testing (should not be visible in production)
      var autoValue = (isDev) ? 'Skoalstrjitte 14, Sexbierum' : '';
      var schoolName = (isDev) ? 'de Skeakel' : '';
      var selected = (isDev) ? 'selected' : '';
      res.render('_register' , {
        'title':'Start',
        'autocompleteValue': autoValue,
        'uid': uid,
        'isteacher': isteacher,
        'shoppinglist' : shoppinglist,
        'schoolName' : schoolName,
        'selected' : selected
      });
    }
  });
});

/**
 * user is already added to database,
 * so we redirect from the 'start/register' page to the previous added info page
 *
 * !! assumption is that all the checks are done in the register!
 */
app.get('/score', function (req,res) {
  var uid = req.query.uid;
  // TODO : [mck] this needs to be the entries from result
  TrashCollection.find({'uid': uid} , function (err, result) {
    console.log('err: ' , err, 'result: ' , result);
    if (err) {
      return;
    }
    res.render('_score' , {
      'title': 'Score',
      'uid': req.query.uid,
      'isteacher': req.query.isteacher,
      'result': result
    });
  });
});

/**
 * the editor is the shoppingList of trash
 * you can find the content in `shoppinglist` and that will be rendered by Swig-templating in the `view/_editor.html` file
 *
 * we can savely assume that `uid` and `isteacher` is valid htere
 */
app.get('/editor', function (req,res) {
	// res.sendFile( path.resolve(__dirname , '../public/editor.html'));
  // console.log(req);
  // console.log(req.query);
  // console.log(req.query.isteacher);
  var uid = (req.query.uid) ? req.query.uid : '';
  var isteacher = false;
  isteacher = (req.query.isteacher === undefined || req.query.isteacher === '') ? false : req.query.isteacher;
  // [mck] just use this address for testing (should not be visible in production)

  RegisterUser.findOne({'uid': uid} , function (err, result) {
    // console.log('err: ' , err, 'result: ' , result);
    if (err) return;
    if(result){
      console.log(result);
      res.render('_editor' , {
        'title':'Editor',
        'uid': uid,
        'isteacher': isteacher,
        'shoppinglist' : shoppinglist,
        'lng':result.lng,
        'lat':result.lat
      });
    }
  });
});

/**
 * feedback for submitting the form,
 *
 * should have links to
 *    - homepage (could focus on that specific area from the user)
 *    - score page (submit user had done, in the past)
 *    - add another batch (editor)
 */
app.get('/thx', function (req,res) {
  // TODO get the value from the url
  res.render('_thx' , {
    'title':'Bedankt',
    'uid': req.query.uid,
    'isteacher': req.query.isteacher,
    'total': req.query.total,
    'lng': req.query.lng,
    'lat': req.query.lat,
  });
});

/**
 * test iframe
 */
app.get('/iframe', function (req,res) {
	// res.sendFile( path.resolve(__dirname , '../public/test.html'));
  res.render('_iframe' , {
    title: 'iframe',
    'uid': req.query.uid,
    'isteacher': req.query.isteacher,
  });
});

/**
 * repeating visual test should be done here
 */
app.get('/student', function (req,res) {
	// res.sendFile( path.resolve(__dirname , '../public/test.html'));
  res.render('_student' , {
    title: 'Student'
  });
});

/**
 * repeating visual test should be done here
 */
app.get('/test', function (req,res) {
	// res.sendFile( path.resolve(__dirname , '../public/test.html'));
  res.render('_test' , {
    title:"Test"
  });
});


// Use express's default error handling middleware
// app.use((err, req, res, next) => {
//   if (res.headersSent) return next(err);
//   res.status(400).json({ err: err });
// });


app.use(function (req, res, next) {
	res.sendFile( path.resolve(__dirname , '../public/404.html'));
});

app.use(function (err, req, res, next) {
	res.sendFile( path.resolve(__dirname , '../public/500.html'));
});


// Start the server
const server = app.listen(config.port, () => {
  // console.log(`Listening on port ${config.port}`);
  // console.info('>>> 🌎 Open http://0.0.0.0:%s/ in your browser.', config.port);
  console.info('>>> 🌎 Open http://localhost:%s/ in your browser.', config.port);
});

// Set up socket.io
const io = socket(server);
let online = 0;

io.on('connection', (socket) => {
  online++;
  console.log(`Socket ${socket.id} connected.`);
  console.log(`Online: ${online}`);
  io.emit('visitor enters', online);

  socket.on('add', data => socket.broadcast.emit('add', data));
  socket.on('update', data => socket.broadcast.emit('update', data));
  socket.on('delete', data => socket.broadcast.emit('delete', data));
  socket.on('message', data => console.log( data ));

  socket.on('disconnect', () => {
    online--;
    console.log(`Socket ${socket.id} disconnected.`);
    console.log(`Online: ${online}`);
    io.emit('visitor exits', online);
  });
});
