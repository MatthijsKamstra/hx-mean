var express = require('express');
var router = express.Router();

const RegisterUser = require('../models/registeruser');
const TrashCollection = require('../models/trashcollection');

router.get('/superheros', function(req, res) {
  res.render('api', { title: 'Superhero API' });
});

router.post('/superheros', function(req, res) {
  console.log(req.body.name);
  res.redirect('/api/superheros');
});

// CREATE
router.post('/trash', function(req, res) {
  // console.log(req);
  var json = JSON.parse(JSON.stringify(req.body));
	console.log('body: ', json);
  var tCollection = new TrashCollection({
    uid : json.uid,
    isteacher : json.isteacher,
    lng : json.lng,
    lat : json.lat,
    question : json.question,
    total : json.total,
    data : json.data
  });
  TrashCollection.create(tCollection, (error) => {
    if (!error) {
      console.log('Created TrashCollection: ', tCollection);
      return res.status(200).json({ success: true, msg: `this is correct`, url:`/thx?uid=${json.uid}&isteacher=${json.isteacher}&total=${json.total}&lng=${json.lng}&lat=${json.lat}` });
    } else {
      console.log('Something went wrong | error: ',error);
      return res.status(500).json({ success: false, msg: `Something went wrong. ${err}` });
    }
  });
});

// CREATE
router.post('/register', function(req, res) {
  // console.log(req);
  var json = JSON.parse(JSON.stringify(req.body));
	console.log('body: ', json);
	// console.log('body: ' + JSON.stringify(req.body));
	// res.send(req.body);
  // // console.log(req.body);
  // // res.redirect('/editor');


  var rUser = new RegisterUser({
    uid : json.uid, //"123456nav",
    isteacher : json.isteacher, //"true",

    schoolname : json.schoolname, //"de Skeakel",
    group : json.group, //"5",
    groupid : json.groupid, //"5",

    lng : json.lng,
    lat : json.lat,

    streetname : json.streetname, //"Skoalstrjitte",
    route : json.streetname, //"Skoalstrjitte",
    street_number : json.streetnumber, //"14",
    streetnumber : json.streetnumber, //"14",
    zipcode : json.zipcode, //"8855 HL",
    postal_code : json.zipcode, //"8855 HL",
    city : json.city, //"Sexbierum",
    locality : json.city, //"Sexbierum",
    administrative_area_level_1 : json.provincie, //"Friesland",
    provincie : json.provincie, //"Friesland"
    country : json.country, //"Netherlands",

    formatted_address : json.streetname + ' ' + json.streetnumber + ', ' + json.zipcode + ' ' + json.city + ', ' + json.country, //"Skoalstrjitte 14, 8855 HL Sexbierum, Netherlands",
    autocomplete : json.streetname + ' ' + json.streetnumber + ', ' + json.zipcode + ' ' + json.city + ', ' + json.country, //"Skoalstrjitte 14, Sexbierum, Netherlands",

    geometry : JSON.parse(json.geometry),

    place : JSON.parse(json.place), // that just everything google maps sends
  });

  // console.log(rUser);
  // userArray.push(rUser)
  RegisterUser.create(rUser, (error) => {
    if (!error) {
      console.log('User is registered');
      // res.redirect('/editor'); // doesn't work like that
      // res.location('/editor'); // doesn't work like that
      return res.status(200).json({ success: true, msg: `this is correct`, url:`/editor?uid=${json.uid}&isteacher=${json.isteacher}` });
    } else {
      console.log('something went terrible wrong: ', error);
      return res.status(500).json({ success: false, msg: `Something went wrong. ${err}` });
    }
  });


});

// READ (ONE)
router.get('/id/:id', (req, res) => {
  const id = req.params.id;
  RegisterUser.find({'uid': id} , function (err, result) {
    if (err) return res.status(500).json({ success: false, msg: `Something went wrong. ${err}` });
    res.json(result);
  });

});

// READ (ALL)
router.get('/register/all', (req, res) => {
  console.log('/register/all');
  // console.log(req);
  // console.log(res);

  RegisterUser.find({} , function (err, result) {
    if (err) return res.status(500).json({ success: false, msg: `Something went wrong. ${err}` });
    res.json(result);
  });

});

module.exports = router;
