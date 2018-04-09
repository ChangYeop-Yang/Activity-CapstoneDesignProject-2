
var https = require('https');
var express = require('express');

var fs = require('fs');

var options = {
	key: fs.readFileSync('./key/private.pem'),
	cert: fs.readFileSync('./key/public.pem')
};

var airQualityObject = require('./AirQuality');
var cameraObject  = require('./Camera');
var fireObject  = require('./Fire');
var gasObject  = require('./Gas');
var lightObject  = require('./Light');
var rfidObject  = require('./RFID');
var noizeObject  = require('./Noize');
var humidityObject  = require('./Humidity');
var temperatureObject  = require('./Temperature');

var testPort = 8080;
//var httpsPort = 443;

var server = express();

server.use(express.urlencoded());


https.createServer(options, server).listen(testPort, function () {
	console.log("HTTPS server listening on port " + testPort);
});

/*server.get('/setAirQuality', AirQuality.setData);
server.get('/setCamera', Camera.setData);
server.get('/setFire', Fire.setData);
server.get('/setGas', Gas.setData);
server.get('/setLight', Light.setData);
server.get('/setRFID', RFID.setData);
server.get('/setNoize', Noize.setData);*/

server.get('/getAirQuality', function (res, req) {
	airQualityObject.getData(res, req);
});
server.get('/getFire', function (res, req) {
	fireObject.getData(res, req);
});
server.get('/getGas', function (res, req) {
	gasObject.getData(res, req);
});
server.get('/getLight', function (res, req) {
	lightObject.getData(res, req);
});
server.get('/getRFID', function (res, req) {
	rfidObject.getData(res, req);
});
server.get('/getNoize', function (res, req) {
	noizeObject.getData(res, req);
});
server.get('/getTemperature', function (res, req) {
	temperatureObject.getData(res, req);
});
server.get('/getHumidity', function (res, req) {
    humidityObject.getData(res, req);
});


/*server.post('/getCamera', O_camera.setData);
server.post('/getFire', O_fire.setData);
server.post('/getGas', O_gas.setData);
server.post('/getLight', O_light.setData);
server.post('/getRFID', O_rfid.setData);
server.post('/getSound', O_sound.setData);*/

//console.log(airQualityData);