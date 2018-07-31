const mongoose = require('mongoose');

const RegisterSchema = new mongoose.Schema({
	// count: {
	// 	type: Number,
	// 	default: 0
	// }
	uid : {
		type: String, //123456nav
	},
	isteacher : {
		type: Boolean, //true
	},
	street_number : {
		type: Number, //14
	},
	route : {
		type: String, //Skoalstrjitte
	},
	locality : {
		type: String, //Sexbierum
	},
	administrative_area_level_1 : {
		type: String, //Friesland
	},
	country : {
		type: String, //Netherlands
	},
	postal_code : {
		type: String, //8855 HL
	},
	place : { },
	formatted_address : {
		type: String, //Skoalstrjitte 14, 8855 HL Sexbierum, Netherlands",
	},
	geometry : {},
	lat : {
		type: Number
	},
	lng : {
		type: Number
	},
	schoolname : {
		type: String, //de Skeakel
	},
	group : {
		type: Number, //5
	},
	groupid : {
		type: String, // a
	},
	autocomplete : {
		type: String, //Skoalstrjitte 14, Sexbierum, Netherlands
	},
	streetname : {
		type: String, //Skoalstrjitte
	},
	streetnumber : {
		type: Number, //14
	},
	zipcode : {
		type: String, //8855 HL
	},
	city : {
		type: String, //Sexbierum
	},
	provincie : {
		type: String, //Friesland
	}

}, {timestamps:true});

module.exports = mongoose.model('RegisterUser', RegisterSchema);
