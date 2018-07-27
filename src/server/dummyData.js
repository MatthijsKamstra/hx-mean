const RegisterUser = require('./models/registeruser');
const TrashCollection = require('./models/trashcollection');

const faker = require('faker');
faker.locale = ("nl");


const latlngArray = [
  // amsterdam
  {lat: 52.370216, lng: 4.895168},
  // Maastricht
  {lat: 50.851368, lng: 5.690973},
  // Lelystad
  {lat: 52.518536, lng: 5.471422},
  // Amsterdam
  {lat: 52.371807, lng: 4.896029},
  // Emmen
  {lat: 52.785805, lng: 6.897585},
  // Waalwijk
  {lat: 51.687897, lng: 5.057482},
  // Amsterdam
  {lat: 52.377956, lng: 4.897070},
  // Zaandam
  {lat: 52.442039, lng: 4.829199},
  // Leiden
  {lat: 52.160114, lng: 4.497010},
  // Amsterdam
  {lat: 52.370216, lng: 4.895168},
  // The Hague
  {lat: 52.078663, lng: 4.288788},
];

module.exports = {

  trashCollection : function (){

    TrashCollection.find({}).count().exec((err, count) => {
      if (count > 0) {
        return;
      }
      console.log(`TrashCollection.count : ${count}, lets make some dummy data`);
      for (let i = 0; i < 100; i++) {
        var question = faker.company.catchPhrase();
        var pos = latlngArray[Math.floor(Math.random() * latlngArray.length)];
        var tCollection = new TrashCollection({
          uid : faker.random.uuid(),
          isteacher : true,
          lat : pos.lat,
          lng : pos.lng,
          question : question,
          data : {
            "flessen_groot" : Math.round(Math.random()*20),
            "flessen_klein" : Math.round(Math.random()*20),
            "blikjes" : Math.round(Math.random()*20),
            "pakjes" : Math.round(Math.random()*20),
            "tassen" : Math.round(Math.random()*20),
            "snack" : Math.round(Math.random()*20),
            "overige" :Math.round(Math.random()*20),
            "question" : question,
          }
        });
        TrashCollection.create(tCollection, (error) => {
          if (!error) {
            console.log('Created TrashCollection: ', tCollection);
          } else {
            console.log('Something went wrong | error: ',error);
          }
        });
      }
    });
  },
  registerUsers : function (){

    RegisterUser.count().exec((err, count) => {
      if (count > 0) {
        return;
      }
      console.log(`RegistedUser.count : ${count}, lets create some dummy data`);

      // var randomName = faker.name.findName(); // Rowan Nikolaus
      // var randomEmail = faker.internet.email(); // Kassandra.Haley@erich.biz
      // var randomCard = faker.helpers.createCard(); // random contact card containing many properties

      // var userArray = [];

      for (let i = 0; i < 10; i++) {

        var randomStreetNumber = Math.round(Math.random()*500);
        var randomStreetName = faker.address.streetName();
        var randomZipcode = faker.address.zipCode();
        var randomCity = faker.address.city();
        var randomProvincie = faker.address.state();
        var randomChar = ['0','1','2','3','a','b','c','d',' ', '*', 'henk' ];

        var rUser = new RegisterUser({
          uid : faker.random.uuid(), //"123456nav",
          isteacher : true, //"true",

          schoolname : faker.company.companyName(), //"de Skeakel",
          group : Math.round(Math.random(8)*10), //"5",
          groupid : randomChar[Math.floor(Math.random() * randomChar.length)],

          streetname : randomStreetName, //"Skoalstrjitte",
          route : randomStreetName, //"Skoalstrjitte",
          street_number : randomStreetNumber, //"14",
          streetnumber : randomStreetNumber, //"14",
          zipcode : randomZipcode, //"8855 HL",
          postal_code : randomZipcode, //"8855 HL",
          city : randomCity, //"Sexbierum",
          locality : randomCity, //"Sexbierum",
          administrative_area_level_1 : randomProvincie, //"Friesland",
          provincie : randomProvincie, //"Friesland"
          country : 'Netherlands', //"Netherlands",

          formatted_address : randomStreetName + ' ' + randomStreetNumber + ', ' + randomZipcode + ' ' + randomCity + ', ' + 'Netherlands', //"Skoalstrjitte 14, 8855 HL Sexbierum, Netherlands",
          autocomplete : randomStreetName + ' ' + randomStreetNumber + ', ' + randomZipcode + ' ' + randomCity + ', ' + 'Netherlands', //"Skoalstrjitte 14, Sexbierum, Netherlands",

          geometry : {
            "location":{
              "lat":faker.address.latitude(),
              "lng":faker.address.longitude()
            },
            "viewport":{
              "south":53.21726736970851,
              "west":5.485794869708457,
              "north":53.21996533029151,
              "east":5.488492830291534
            }
          },
          place : {}, // that just everything google maps sends
        });

        // console.log(rUser);
        // userArray.push(rUser)
        RegisterUser.create(rUser, (error) => {
          if (!error) {
            console.log('Created a RegisterUser: ', rUser);
          } else {
            console.log('Something went wrong | error: ', error);
          }
        });
      }


      // const post1 = new Post({ name: 'Admin', title: 'Hello MERN', slug: 'hello-mern', cuid: 'cikqgkv4q01ck7453ualdn3hd', content: content1 });
      // const post2 = new Post({ name: 'Admin', title: 'Lorem Ipsum', slug: 'lorem-ipsum', cuid: 'cikqgkv4q01ck7453ualdn3hf', content: content2 });

    });
  }

}
