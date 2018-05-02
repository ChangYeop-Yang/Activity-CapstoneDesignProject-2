var repeatNum = 1;
var time;
var temperature = 0;
var humidity=0;
var noise = 0;
var gas = 0;
var ipAddress = 0;

var DBData = require('../../RealmDB');

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
        console.log("Aduino will send Data--livingroom");
	    var currentTime = new Date();
	    time = currentTime.yyyymmdd();

        console.log('previous temperature = ' + temperature);
        temperature = req.query.temp;

        console.log('previous humidity = ' + humidity);
        humidity = req.query.hum;

        console.log('previous noise = ' + noise);
		noise = req.query.noise;

        console.log('previous gas = ' + gas);
        gas = req.query.gas;

        ipAddress = req.connection.remoteAddress;
        res.send('SEND OK');
        DBData.createLIvingRoomDBData(repeatNum++,time,temperature,humidity,noise,gas,ipAddress);
        console.log(ipAddress + ' send data at ' + time);
	},

    getData: function(req, res){
        var DBObject = DBData.getLivingRoomDBData();
       /* for (var loop = 1; loop<=DBObject.length; loop++){

        }*/
        console.log(DBObject);
       res.send(DBObject);

        /*var jsonObj = {
            "N_ORD": kitchenObject.N_ORD,
            "Insert_DT": kitchenObject.Insert_DT,
            "Temp_NO": kitchenObject.Temp_NO,
            "Cmd_NO": kitchenObject.Cmd_NO,
            "Noise_NO": kitchenObject.Noise_NO,
            "Flare_FL": kitchenObject.Flare_FL,
            "IP_ID": kitchenObject.IP_ID,

        }*/

        //var kitchenStr += JSON.stringify(jsonObj);


        //console.log(kitchenStr);
        //res.send(kitchenStr);
        //res.end();

    }

}

