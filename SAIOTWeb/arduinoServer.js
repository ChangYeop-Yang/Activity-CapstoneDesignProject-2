var net = require('net');
var kitchenObject = require('./views/Kitchen/Kitchen');
var livingRoomObject = require('./views/LivingRoom/LivingRoom');
var outDoorObject = require('./views/OutDoor/OutDoor');



Date.prototype.yyyymmdd = function () {
    var month = this.getMonth() + 1;
    var day = this.getDate();
    var hours = this.getHours();
    var minutes = this.getMinutes();
    var second = this.getSeconds();
    return [this.getFullYear() + '-' + (month > 9 ? "" : "0") + month + '-' + (day > 9 ? "" : "0") + day + ' ' + (hours > 9 ? "" : "0") + hours + ':' + (minutes > 9 ? "" : "0") + minutes + ':' + (second > 9 ? "" : "0") + second]
}

module.exports={
    createArduinoServer : function(port) {
        var server = net.createServer(function (client) {
            console.log('Client connection: ');
            console.log('   local = %s:%s', client.localAddress, client.localPort);
            console.log(new Date().yyyymmdd() + '   remote = %s:%s', client.remoteAddress, client.remotePort);

            client.on('data', function (data) {
                console.log(new Date().yyyymmdd() + ' : Received data from Arduino client : ' +   data.toString());
                var inputData = (data.toString()).split(/\?| /);

                //Data checking
                if(inputData[0] == "GET" && inputData[1] == "/setKitchenData"){
                    kitchenObject.setData(client,inputData[2]);
                }

                else if(inputData[0] == "GET" && inputData[1] == "/setLivingRoomData"){
                    livingRoomObject.setData(client, inputData[2]);
                }

                else if(inputData[0] == "GET" && inputData[1] == "/setOutDoorData"){
                    outDoorObject.setData(client, inputData[2]);
                }

            });
            client.on('end', function () {
                console.log('Client disconnected');
                server.getConnections(function (err, count) {
                    console.log('Remaining Connections: ' + count);
                });
            });
        });

        server.listen(port, function () {
            console.log('Arduino listening: ' + JSON.stringify(server.address()));
            server.on('close', function () {
                console.log('Server Terminated');
            });
            server.on('error', function (err) {
                console.log('Server Error: ', JSON.stringify(err));
            });
        });

        /*function writeData(socket, data) {
            var success = !socket.write(data);
            if (!success) {
                (function (socket, data) {
                    socket.once('drain', function () {
                        writeData(socket, data);
                    });
                })(socket, data);
            }
        }*/
    }
}