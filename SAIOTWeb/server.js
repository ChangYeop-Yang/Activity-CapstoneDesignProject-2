var http = require('http');
//var https = require('https');
var express = require('express');
var fs = require('fs');


Date.prototype.yyyymmdd = function () {
    var month = this.getMonth() + 1;
    var day = this.getDate();
    var hours = this.getHours();
    var minutes = this.getMinutes();
    var second = this.getSeconds();
    return [this.getFullYear() + '-' + (month > 9 ? "" : "0") + month + '-' + (day > 9 ? "" : "0") + day + ' ' + (hours > 9 ? "" : "0") + hours + ':' + (minutes > 9 ? "" : "0") + minutes + ':' + (second > 9 ? "" : "0") + second]
};

var options = {
    key: fs.readFileSync('bin/key/private.pem'),
    cert: fs.readFileSync('bin/key/public.pem')
};
var arduinoServer = require('./arduinoServer');
var kitchenObject = require('./views/Kitchen/Kitchen');
var livingRoomObject = require('./views/LivingRoom/LivingRoom');
var outDoorObject = require('./views/OutDoor/OutDoor');


var httpsPort = 443;


var httpPort = 80;
var server = express();
var httpServer = http.createServer(server);


//var arduinoServer = https.createServer(options,httpsServer);
//var mobileConnectionServer = http.createServer(httpServer);

//var io = sokIO(server);

/*/var kitchenSocket = io.connect('http://localhost/setKitchenData?');
io.on('connection',function(socket){
    console.log('mobile client connection , ip : ' + socket.handshake.address);

    socket.on('disconnect',function(){
       console.log('mobile client disconnection , ip : ' + socket.handshake.address);
    });
});*/
/*https.createServer(options,httpsServer).listen(httpsPort, function () {
    console.log("HTTP server listening on port " + httpsPort);
});*/

httpServer.listen(httpPort, function () {
    console.log("HTTP server listening on port " + httpPort);
});

/////Usage : Get data from arduino by TCP Connection
arduinoServer.createArduinoServer(8080);

server.use('/',function (req,res) {
    console.log(new Date().yyyymmdd() + 'new person coming Web Server : '+req.connection.remoteAddress);
    res.send("SAIOT SERVER IS WORKING!!");
});

server.use('/setKitchenData',function (req,res) {
    console.log('Arduino Kitchen device connection, ip : ' + req.connection.remoteAddress);
    kitchenObject.setData(req,res);
    //kitchenObject.getData(io);
});

/*
server.use('/setLivingRoomData',function (req,res) {
    console.log('Arduino LivingRoom device connection, ip : ' + req.connection.remoteAddress);
    livingRoomObject.setData(req,res);
    //kitchenObject.getData(io);
});

server.use('/setOutDoorData',function (req,res) {
    console.log('Arduino OutDoor device connection, ip : ' + req.connection.remoteAddress);
    outDoorObject.setData(req,res);
    //kitchenObject.getData(io);
});*/


//show data to mobile application
server.get('/getKitchenData', function (res, req) {
    kitchenObject.getData(res, req);
});

server.get('/getLivingRoomData', function (res, req) {
    livingRoomObject.getData(res, req);
});

server.get('/getOurDoorData', function (res, req) {
    outDoorObject.getData(res, req);
});


//Get Kitchen information from Arduino to DB

/*
var ioMobileConnection = sokIO(mobileConnectionServer);
var ioArduinoConnection = sokIO(arduinoServer);
//var ioArduinoLivingRoomConnecdtion = sokIO(arduinoServer);
//var ioArduinoOutDoorConnection = sokIO(arduinoServer);

httpsServer.get('/',function (req,res) {
    res.sendfile(__dirname + '/index.html');
});

ioMobileConnection.on('connection',function(socket) {
    console.log('mobile client connection , ip : ' + socket.handshake.address);
});

arduinoServer.listen(httpPort, function () {
    console.log("HTTP server listening on port " + httpPort);
});

mobileConnectionServer.listen(httpsPort,function(){
    console.log("HTTPS server listening on port " + httpsPort);
});

/*httpServer.get('/',function (req,res) {
    res.sendFile(__dirname + '/index.html');
})

httpServer.get('/setKitchenData',function (req,res) {
    res.sendfile('index.html');
});

httpServer.get('/setLivingRoomData',function (req,res) {
    res.sendfile('index.html');
});*/
/*
//Get Kitchen information from Arduino to DB
ioArduinoConnection.on('connection',function(socket){

    console.log('Arduino Kitchen device connection, ip : ' + socket.handshake.address);
    kitchenObject.setData(socket);
    kitchenObject.getData(ioMobileConnection);
})*/

//Get LivingRoom information from Arduino to DB
/*ioArduinoLivingRoomConnecdtion.of('/setLivingRoomData').on('connection',function(socket){
    livingRoomObject.setData(socket);
    livingRoomObject.getData(ioMobileConnection);
    //console.log(socket.emit('LivingRoomData',livingRoomObject.getData()));
});*/

/*
server.get('/setOutDoorData',function (req,res) {
    //res.sendfile('index.html');
});*/

/*
//Get Kitchen information from Arduino to DB
ioArduinoKitchenConnection.of('/setKitchenData').on('connection',function(socket){
    console.log('Arduino Kitchen device connection, ip : ' + socket.handshake.address);
    kitchenObject.setData(socket);
    kitchenObject.getData(ioMobileConnection);
})

//Get LivingRoom information from Arduino to DB
ioArduinoLivingRoomConnecdtion.of('/setLivingRoomData').on('connection',function(socket){
    livingRoomObject.setData(socket);
    livingRoomObject.getData(ioMobileConnection);
    //console.log(socket.emit('LivingRoomData',livingRoomObject.getData()));
});

//Get Infrared Control Information from LivingRoom Arduino
/*server.get('/SetRemoteControl', function (res, req) {
    livingRoomInfraRedObject.setData(res, req);
});*/


