
var https = require('https');
var express = require('express');

var fs = require('fs');

var options = {
	key: fs.readFileSync('./key/private.pem'),
	cert: fs.readFileSync('./key/public.pem')
};

var O_airQuality = require('./AirQuality');
var O_camera = require('./Camera');
var O_fire = require('./Fire');
var O_gas = require('./Gas');
var O_light = require('./Light');
var O_rfid = require('./RFID');
var O_noize = require('./Noize');
var O_humidity = require('./Humidity');
var O_temperature = require('./Temperature');

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
	O_airQuality.getData(res, req);
});
server.get('/getFire', function (res, req) {
	O_fire.getData(res, req);
});
server.get('/getGas', function (res, req) {
	O_gas.getData(res, req);
});
server.get('/getLight', function (res, req) {
	O_light.getData(res, req);
});
server.get('/getRFID', function (res, req) {
	O_rfid.getData(res, req);
});
server.get('/getNoize', function (res, req) {
	O_noize.getData(res, req);
});
server.get('/getTemperature', function (res, req) {
	O_temperature.getData(res, req);
});
server.get('/getHumidity', function (res, req) {
	O_humidity.getData(res, req);
});


/*server.post('/getCamera', O_camera.setData);
server.post('/getFire', O_fire.setData);
server.post('/getGas', O_gas.setData);
server.post('/getLight', O_light.setData);
server.post('/getRFID', O_rfid.setData);
server.post('/getSound', O_sound.setData);*/

//console.log(airQualityData);