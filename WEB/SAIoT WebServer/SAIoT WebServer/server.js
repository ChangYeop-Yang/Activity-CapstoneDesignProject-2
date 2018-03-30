var http = require('http');
var WebSocketServer = require('websocket').server;
var port = 8080;

var serverConnectionCheck = require('./serverConnectionCheck');
var serverRead = require('./serverRead');
var serverWrite = require('./serverWrite');


var server = http.createServer(function (request, response) {
	console.log('Time : ' + (new Date()) + 'Received request for ' + request.url);
	response.writeHead(404);
	response.end();
});

server.listen(8000, function () {
	console.log('listening...')
});

webSocketServer = new WebSocketServer({
	httpServer: server, autoAcceptConnections: false
});

webSocketServer.on('request', function (request) {

	if (!serverConnectionCheck.originAllowed(request.origin)) {
		request.reject();
		console.log('Time : ' + (new Date()) + request.origin + ' Connection rejected.');
		return;
	}

	var connection = request.accept(null, request.origin);
	console.log((new Date()) + ' Connection accepted.');

	connection.on('message', function (message) {
		console.log('message : ' + message.type);
		var getData = serverRead.readData(message);
		console.log('Received Message: from' + request.origin +' : ' + getData);
		serverWrite.writeData(connection, getData);
	});



	connection.on('close', function (reasonCode, description) {
		console.log((new Date()) + ' Peer ' + connection.remoteAddress + ' disconnected.');
	});



});

/*http.createServer(function (req, res) {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end('Hello World\n');
}).listen(port);*/
