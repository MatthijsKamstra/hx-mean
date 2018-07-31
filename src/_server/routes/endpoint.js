var express = require('express');
var router = express.Router();

router.post('/', function(req, res){
	var obj = {};
	console.log('body: ' + JSON.stringify(req.body));
	res.send(req.body);
});


module.exports = router;
