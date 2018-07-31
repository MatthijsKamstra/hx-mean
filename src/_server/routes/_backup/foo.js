var express = require('express');
var faker = require('faker');
faker.locale = "nl";



module.exports = function(app) {

var randomName = faker.name.findName(); // Rowan Nikolaus
var randomEmail = faker.internet.email(); // Kassandra.Haley@erich.biz
var randomCard = faker.helpers.createCard(); // random contact card containing many properties


//   var router = express.Router();

//   router.get('/', function (req, res, next) {
//     res.json({status: 'UP'});
//   });

//   app.use("/health", router);
}
