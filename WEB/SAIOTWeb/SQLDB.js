const sqlite3 = require('sqlite3').verbose();
var dbFileName = "SAIOTDatabase.db";
var db = new sqlite3.Database('./db/' + dbFileName);


db.run('CREATE TABLE IF NOT EXISTS KitchenDB(\
    N_ORD            INTEGER PRIMARY KEY autoincrement NOT NULL,\
    Insert_DT        TEXT,\
    Temp_NO          INTEGER,\
    CDS_NO           INTEGER,\
    Noise_NO         INTEGER,\
    Flare_FL         INTEGER,\
    Gas_FL           INTEGER,\
    IP_ID            TEXT)'
);

db.run('CREATE TABLE IF NOT EXISTS LivingRoomDB(\
    N_ORD            INTEGER PRIMARY KEY autoincrement NOT NULL,\
    Insert_DT        TEXT,\
    Temp_NO          INTEGER,\
    CDS_NO           INTEGER,\
    Noise_NO         INTEGER,\
    Gas_FL           INTEGER,\
    IP_ID            TEXT)'
);

// control log????

db.run('CREATE TABLE IF NOT EXISTS OutDoorDB(\
    N_ORD            INTEGER PRIMARY KEY autoincrement NOT NULL,\
    Insert_DT        TEXT,\
    RFID_SET         INTEGER,\
    IP_ID            TEXT)'
);

module.exports = {
    createKitchenDBData: function (date, temperature, light, noise, flare, gas, ipAddress) {
        db.run("INSERT INTO KitchenDB(Insert_DT,Temp_NO,CDS_NO,Noise_NO,Flare_FL,Gas_FL,IP_ID)\
                VALUES ('" + String(date) + "'\
                ," + parseInt(temperature) + "\
                ," + parseInt(light) + "\
                ," + parseInt(noise) + "\
                ," + parseInt(flare) + "\
                ," + parseInt(gas) + "\
                ,'" + String(ipAddress) + "')", function (err) {
            console.log('error : ' + err);
        });
    },

    getKitchenDBData: function (callback) {
        var sql = 'SELECT AVG(Temp_NO), AVG(CDS_NO), AVG(Noise_NO), AVG(Gas_FL), Insert_DT FROM \
        KitchenDB GROUP BY YEAR(Insert_DT), MONTH(Insert_DT), DAY(Insert_DT) LIMIT 30';
        db.all(sql, function (err, rows) {
            callback(rows);
        });
        //SELECT AVG(Temp_NO), AVG(Cmd_NO), AVG(Noise_NO), AVG(Gas_FL), Insert_DT FROM `Kitchen` GROUP BY YEAR(Insert_DT), MONTH(Insert_DT), DAY(Insert_DT) LIMIT 30


    },

    createLIvingRoomDBData: function (date, temperature, light, noise, gas, ipAddress) {
        db.run("INSERT INTO KitchenDB(Insert_DT,Temp_NO,CDS_NO,Noise_NO,Gas_FL,IP_ID)\
                VALUES ('" + String(date) + "'\
                ," + parseInt(temperature) + "\
                ," + parseInt(light) + "\
                ," + parseInt(noise) + "\
                ," + parseInt(gas) + "\
                ,'" + String(ipAddress) + "')", function (err) {
            console.log('error : '+ err);
        });
    },

    getLivingRoomDBData: function (callback) {
        var sql = 'SELECT AVG(Temp_NO), AVG(CDS_NO), AVG(Noise_NO), AVG(Gas_FL), Insert_DT FROM \
            LivingRoomDB GROUP BY YEAR(Insert_DT), MONTH(Insert_DT), DAY(Insert_DT) LIMIT 30';
        db.all(sql, function (err, rows) {
            callback(rows);
        });
    },

    createOutDoorDBData: function (date, rfidID, ipAddress) {
        db.run("INSERT INTO OutDoorDB(Insert_DT,,IP_ID)\
                VALUES ('" + String(date) + "'\
                ,'" + String(ipAddress) + "')", function (err) {
            console.log('error : '+ err);
        });
    },

    //  RFID_SET


    getOutDoorDBData: function (callback) {
        var sql = 'SELECT RFID_SET,Insert_DT FROM \
            getOutDoorDB GROUP BY YEAR(Insert_DT), MONTH(Insert_DT), DAY(Insert_DT) LIMIT 30'
        db.all(sql, function (err, rows) {
            callback(rows);
        });
    }

}
