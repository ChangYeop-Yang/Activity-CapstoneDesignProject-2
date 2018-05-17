var http = require('http');
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
var tcpConnection = require('./TCPConnection');
var kitchenObject = require('./views/Kitchen/Kitchen');
var livingRoomObject = require('./views/LivingRoom/LivingRoom');
var outDoorObject = require('./views/OutDoor/OutDoor');

var httpsPort = 443;

var httpPort = 80;
var arduinoPort = 8080;
var mobilPort = 8090;


var server = express();
var httpServer = http.createServer(server);

httpServer.listen(httpPort, function () {
    console.log("HTTP server listening on port " + httpPort);
});

/////Usage : Get data from Aruino, mobile by TCP Connection to event handle
tcpConnection.tcpServer(arduinoPort,mobilPort);

server.get('/',function (req,res) {
    console.log(new Date().yyyymmdd() + 'new person coming Web Server : '+req.connection.remoteAddress);
    res.send("SAIOT SERVER IS WORKING!!");
});

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
