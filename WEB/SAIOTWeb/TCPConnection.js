var net = require('net');
var kitchenObject = require('./views/Kitchen/Kitchen');
var livingRoomObject = require('./views/LivingRoom/LivingRoom');
var outDoorObject = require('./views/OutDoor/OutDoor');

var arduinoSocketList = [];
var mobileSocketList = [];



Date.prototype.yyyymmdd = function () {
    var month = this.getMonth() + 1;
    var day = this.getDate();
    var hours = this.getHours();
    var minutes = this.getMinutes();
    var second = this.getSeconds();
    return [this.getFullYear() + '-' + (month > 9 ? "" : "0") + month + '-' + (day > 9 ? "" : "0") + day + ' ' + (hours > 9 ? "" : "0") + hours + ':' + (minutes > 9 ? "" : "0") + minutes + ':' + (second > 9 ? "" : "0") + second]
};


module.exports= {
    tcpServer: function (arduinoPort, mobilePort) {

        // var server = net.createServer()
        var arduinoServer = net.createServer(function (client) {

            /////Arduino Client connection////////////////////////////////////////////////
            console.log('Arduino Client connection: ');
            console.log(new Date().yyyymmdd() + ' Address :' + client.remoteAddress + " : " + client.remotePort);
            arduinoSocketList.push(client);

            ////Arduino Send Message
            client.on('data', function (data) {
                console.log(new Date().yyyymmdd() + ' : Received data from Arduino client : ' + data.toString());
                var inputData = (data.toString()).split(/\?|:| /);

                //Data checking
                if (inputData[0] == "GET" && inputData[1] == "/setKitchenData") {
                    kitchenObject.setData(client, inputData[2]);
                }
                else if (inputData[0] == "GET" && inputData[1] == "/setLivingRoomData") {
                    livingRoomObject.setData(client, inputData[2]);
                }
                else if (inputData[0] == "GET" && inputData[1] == "/setOutDoorData") {
                    outDoorObject.setData(client, inputData[2]);
                }

                ///Arduino Emergency Message
                else if (inputData[0] == "ARDUINO" && inputData[1]) {
                    var orderData = "";
                    for(var i = 1; i<inputData.length-1; i++){
                        orderData += inputData[i];
                        orderData += ":"
                    }
                    orderData += inputData[inputData.length-1];
                    sendData(mobileSocketList,orderData);
                }
            });

            ///Arduino client disconnect
            client.on('end', function () {
                console.log('Arduino Client disconnected');
                arduinoSocketList.splice(arduinoSocketList.indexOf(client), 1);
                arduinoServer.getConnections(function (err, count) {
                    console.log('Remaining Connections: ' + count);
                });
            });
            client.on('error', function(err) {
                console.log('Socket Error: ', JSON.stringify(err));
            });
            client.on('timeout', function() {
                console.log('Socket Timed out');
            });

        });

        // var server = net.createServer()
        var mobileServer = net.createServer(function (client) {

            /////Mobile Client connection////////////////////////////////////////////////////
            console.log('Mobile Client connection: ');
            console.log(new Date().yyyymmdd() + ' Address :' + client.remoteAddress + " : " + client.remotePort);
            mobileSocketList .push(client);

            ///Mobile control message get, send to Arduino
            client.on('data', function (data) {
                console.log(new Date().yyyymmdd() + ' : Received data from Mobile client : ' + data.toString());
                var inputData = (data.toString()).split(":");
                console.log(inputData + "mobile Data");
                ///Mobile Control Message
                if (inputData[0] == "MOBILE" && inputData[1]) {
                    var orderData = "";
                    for(var i = 1; i<inputData.length-1; i++){
                        console.log(orderData);
                        orderData += inputData[i];
                        orderData += ":"
                    }
                    orderData += inputData[inputData.length-1];
                    console.log(orderData);
                    sendData(mobileSocketList,orderData);
                }
            });

            ///Mobile client disconnect
            client.on('end', function () {
                console.log('Mobile Client disconnected');
                mobileSocketList.splice(mobileSocketList.indexOf(client), 1);
                mobileServer.getConnections(function (err, count) {
                    console.log('Remaining Connections: ' + count);
                });
            });
            client.on('error', function(err) {
                console.log('Socket Error: ', JSON.stringify(err));
            });
            client.on('timeout', function() {
                console.log('Socket Timed out');
            });


        });


        arduinoServer.listen(arduinoPort, function () {
            console.log('Arduino TCP listening: ' + JSON.stringify(arduinoServer.address()));
            arduinoServer.on('close', function () {
                console.log('Server Terminated');
            });
            arduinoServer.on('error', function (err) {
                console.log('Server Error: ', JSON.stringify(err));
            });
        });


        mobileServer.listen(mobilePort, function () {
            console.log('Mobile TCP listening: ' + JSON.stringify(mobileServer.address()));
            mobileServer.on('close', function () {
                console.log('Server Terminated');
            });
            mobileServer.on('error', function (err) {
                console.log('Server Error: ', JSON.stringify(err));
            });
        });

    }
}

function sendData(clientList,message){
    clientList.forEach(function (client) {
        client.write(message.toString());
    });

}
