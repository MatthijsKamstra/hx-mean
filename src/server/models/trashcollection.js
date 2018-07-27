const mongoose = require('mongoose');

const TrashCollection = new mongoose.Schema({
	isteacher : {
		type: Boolean
	},
    lng : {
		type: String
	},
    lat : {
		type: String
	},
	uid : {
		type: String, //123456nav
	},
	question : {
		type: String,
	},
	data : {}

}, {timestamps:true});

module.exports = mongoose.model('TrashCollection', TrashCollection);
