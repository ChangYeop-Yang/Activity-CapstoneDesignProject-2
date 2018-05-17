var time;
var temperature = 0;
var noise = 0;
var flare = 0;
var gas = 0;
var light = 0;
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

        var currentTime = new Date();
        time = currentTime.yyyymmdd();
        var dataList = data.split(/=|&/);

        //Data paring
        if(dataList.length == 10){
            (dataList[0] =='TEMP' && isFinite(parseInt(dataList[1]))) ?  temperature = parseInt(dataList[1]) : temperature ;
            (dataList[2] =='CDS' && isFinite(parseInt(dataList[3]))) ?  light = parseInt(dataList[3]) : light ;
            (dataList[4] =='NOISE' && isFinite(parseInt(dataList[5]))) ?  noise = parseInt(dataList[5]) : noise ;
            (dataList[6] =='FLARE' && isFinite(parseInt(dataList[7]))) ?  flare = parseInt(dataList[7]) : flare ;
            (dataList[8] =='GAS' && isFinite(parseInt(dataList[9]))) ?  gas = parseInt(dataList[9]) : gas ;
            ipAddress = client.remoteAddress;
            //client.send('SEND OK');
            console.log(time + ' Get Kitchen Data from ' + ipAddress);
            DBData.createKitchenDBData(time, temperature, light, noise, flare, gas, ipAddress);
        }
        else{
            console.log('data format is not match : ' +client.remoteAddress);
        }

    },

    getData: function (req,res) {
        DBData.getKitchenDBData(function (data) {
            //console.log(data);
            //socket.emit('KitchenData', JSON.stringify(data));
            res.send(JSON.stringify(data));
            console.log( (new Date()).yyyymmdd().toString() + ' send data to ' + req.connection.remoteAddress ); //+ socket.handshake.address );
        });
    }
}