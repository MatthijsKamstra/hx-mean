module.exports = function(app){
    require('./public')(app);
    require('./health')(app);
    require('./mongo')(app);
};