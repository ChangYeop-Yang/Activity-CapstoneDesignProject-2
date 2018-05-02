var repeatNum = 1;
var time;
var temperature = 0;
var noise = 0;
var flare = 0;
var gas = 0;
var light = 0;
var ipAddress = 0;

var DBData = require('../../RealmDB');
//var DBData = require('../KitchenDB');

Date.prototype.yyyymmdd = function(){
    var month = this.getMonth()+1;
    var day = this.getDate();
    var hours = this.getHours();
    var minutes = this.getMinutes();
    var second = this.getSeconds();
    return [this.getFullYear() + '-'+ (month>9?"":"0") +month+ '-' + (day>9?"":"0") +day + ' ' + (hours>9?"":"0") + hours + ':' + (minutes>9?"":"0") + minutes + ':' + (second>9?"":"0") + second]
}

module.exports = {
	setData: function (req, res) {

	    var currentTime = new Date();
	    time = currentTime.yyyymmdd();

        console.log('previous temperature = ' + temperature);
        temperature = req.query.temp;

        console.log('previous light = ' + light);
        light = req.query.cmd;

        console.log('previous noise = ' + noise);
		noise = req.query.noise;

        console.log('previous flare = ' + flare);
        flare = req.query.flare;

        console.log('previous gas = ' + gas);
        gas = req.query.gas;

        ipAddress = req.connection.remoteAddress;
        res.send('SEND OK');
        DBData.createKitchenDBData(repeatNum++,time,temperature,light,noise,flare,gas,ipAddress);
        console.log(ipAddress + ' send data at ' + time);
	},

    getData: function(req, res){
        var DBObject = DBData.getKitchenDBData();
        console.log(DBObject);
        res.send(DBObject);
    }

}

