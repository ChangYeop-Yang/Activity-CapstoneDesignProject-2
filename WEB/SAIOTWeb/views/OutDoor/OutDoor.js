var time;
var rfid = 0;
var ipAddress = 0;

var DBData = require('../../SQLDB');

Date.prototype.yyyymmdd = function () {
    var month = this.getMonth() + 1;
    var day = this.getDate();
    var hours = this.getHours();
    var minutes = this.getMinutes();
    var second = this.getSeconds();
    return [this.getFullYear() + '-' + (month > 9 ? "" : "0") + month + '-' + (day > 9 ? "" : "0") + day + ' ' + (hours > 9 ? "" : "0") + hours + ':' + (minutes > 9 ? "" : "0") + minutes + ':' + (second > 9 ? "" : "0") + second]
}

module.exports = {
    setData: function (client,data) {
        //console.log("Aduino will send Data--outdoor");
        var currentTime = new Date();
        time = currentTime.yyyymmdd();
        var dataList = data.split(/=|&/);

        //Data paring
        if(dataList.length == 2){
            (dataList[0] =='RFID' && isFinite(parseInt(dataList[1]))) ?  rfid = (rfid + parseInt(dataList[1]))%2 : rfid ;
            ipAddress = client.remoteAddress;
            //client.send('SEND OK');
            console.log(time + ' Get OutDoorData from ' + ipAddress);
            DBData.createLIvingRoomDBData(time, temperature, light, noise, gas, ipAddress);
        }
        else{
            console.log('data format is not match : ' +client.remoteAddress);
        }
    },

    getData: function (req,res) {
        DBData.getOutDoorDBData(function (data) {
            res.send(JSON.stringify(data));
            console.log( (new Date()).yyyymmdd().toString() + ' send data to ' + req.connection.remoteAddress ); //+ socket.handshake.address );
        });
    }
}