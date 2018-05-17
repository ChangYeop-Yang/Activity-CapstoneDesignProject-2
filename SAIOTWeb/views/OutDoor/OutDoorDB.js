/*var Realm = require('realm');
//var kitchenData = require('./Kitchen');
var outDoor;
const LivingRoomSchema1 = {
    name: 'LivingRoom1325',
    properties: {
        N_ORD : 'int',
        Insert_DT: 'string',
        Temp_NO: 'int',
        Hum_NO: 'int',
        Noise_NO: 'int',
        Gas_FL : 'int',
        IP_ID: 'string',
    }
};
module.exports = {
    createDBData : function(repeatNum,date, temperature, humidity,noise,gas,ipAddress){
        outDoor = new Realm({schema:[LivingRoomSchema1]});
        outDoor.write(() => {
            outDoor.create('LivingRoom1325', {
                    N_ORD : parseInt(repeatNum),
                    Insert_DT: String(date),
                    Temp_NO: parseInt(temperature),
                    Hum_NO: parseInt(humidity),
                    Noise_NO: parseInt(noise),
                    Gas_FL: parseInt(gas),
                    IP_ID: ipAddress,
            });
        })
    },

    getDBData: function(){
        return outDoor.objects('LivingRoom1325');
    }





}
*/
/*
const LivingRoomSchema = {
    name: 'LivingRoom',
    properties: {
        N_ORD: 'int',
        Insert_DT: 'date',
        Temp_NO: 'int',
        Cmd_NO: 'int',
        Noise_NO: 'int',
        Flare_FL: 'int',
        IP_ID: 'string',
    }
};
const OutDoorSchema = {
    name: 'OutDoor',
    properties: {
        N_ORD: 'int',
        Insert_DT: 'date',
        RFID_SET: 'int',
        CameraImage: 'data?',
        IP_ID: 'string',
    }
};*/

