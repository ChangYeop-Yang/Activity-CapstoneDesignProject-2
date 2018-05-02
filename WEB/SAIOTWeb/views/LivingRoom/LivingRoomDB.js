/*var Realm = require('realm');

let livingRoomDB = new Realm({schema:[LivingRoomSchema2]});

module.exports = {
    createDBData : function(repeatNum,date, temperature, humidity,noise,gas,ipAddress){
        livingRoomDB.write(() => {
            livingRoomDB.create('LivingRoom1324', {
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
        if(livingRoomDB.objects('LivingRoom1324'))
            return livingRoomDB.objects('LivingRoom1324');
        else return null;
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

