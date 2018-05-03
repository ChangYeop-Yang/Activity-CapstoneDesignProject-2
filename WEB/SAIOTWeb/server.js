var http = require('http');
var https = require('https');
var express = require('express');
var fs = require('fs');

var options = {
    key: fs.readFileSync('bin/key/private.pem'),
    cert: fs.readFileSync('bin/key/public.pem')
};
var kitchenObject = require('./views/Kitchen/Kitchen');
var livingRoomObject = require('./views/LivingRoom/LivingRoom');


/*var cameraObject  = require('../views/OutDoor/Camera');
var fireObject  = require('../views/Kitchen/Fire');
var gasObject  = require('../views/Kitchen/Gas');
var lightObject  = require('../views/LivingRoom/Light');
var rfidObject  = require('../views/OutDoor/RFID');
var noiseObject  = require('../Noise');
var humidityObject  = require('../Humidity');
var temperatureObject  = require('../Temperature');
*/
var httpsPort = 443;
var httpPort = 80;
var server = express();

server.use(express.urlencoded());

http.createServer(server).listen(httpPort, function () {
    console.log("HTTP server listening on port " + httpPort);
});
https.createServer(options, server).listen(httpsPort, function () {
    console.log("HTTPS server listening on port " + httpsPort);
});


server.get('/setKitchenData', function (res, req) {
    kitchenObject.setData(res, req);
});

server.get('/setLivingRoomData', function (res, req) {
    livingRoomObject.setData(res, req);
});


//show data to mobile application
server.get('/getKitchenData', function (res, req) {
    kitchenObject.getData(res, req);
});
server.get('/getLivingRoomData', function (res, req) {
    livingRoomObject.getData(res, req);
});


/*
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
	noiseObject.getData(res, req);
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