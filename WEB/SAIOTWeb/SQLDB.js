const sqlite3 = require('sqlite3').verbose();
var dbFileName = "SAIOTDatabase.db";
var db = new sqlite3.Database('./db/' + dbFileName);


db.run('CREATE TABLE IF NOT EXISTS KitchenDB(\
    N_ORD            INTEGER PRIMARY KEY autoincrement NOT NULL,\
    Insert_DT        TEXT,\
    Temp_NO          INTEGER,\
    Cmd_NO           INTEGER,\
    Noise_NO         INTEGER,\
    Flare_FL         INTEGER,\
    Gas_FL           INTEGER,\
    IP_ID            TEXT)'
);

db.run('CREATE TABLE IF NOT EXISTS LivingRoomDB(\
    N_ORD            INTEGER PRIMARY KEY autoincrement NOT NULL,\
    Insert_DT        TEXT,\
    Temp_NO          INTEGER,\
    Cmd_NO           INTEGER,\
    Noise_NO         INTEGER,\
    Gas_FL           INTEGER,\
    IP_ID            TEXT)'
);

db.run('CREATE TABLE IF NOT EXISTS OutDoorDB(\
    N_ORD            INTEGER PRIMARY KEY autoincrement NOT NULL,\
    Insert_DT        TEXT,\
    RFID_SET         INTEGER,\
    MOTOR_SET        INTEGER,\
    CAMERA_DATA      INTEGER,\
    IP_ID            TEXT)'
);


module.exports = {
    createKitchenDBData: function (date, temperature, light, noise, flare, gas, ipAddress) {
        db.run("INSERT INTO KitchenDB(Insert_DT,Temp_NO,Cmd_NO,Noise_NO,Flare_FL,Gas_FL,IP_ID)\
                VALUES ('" + String(date) + "'\
                ," + parseInt(temperature) + "\
                ," + parseInt(light) + "\
                ," + parseInt(noise) + "\
                ," + parseInt(flare) + "\
                ," + parseInt(gas) + "\
                ,'" + String(ipAddress) + "')", function (err) {
            console.log(err);
        });
    },

    getKitchenDBData: function (callback) {
        let sql = `SELECT * FROM KitchenDB ORDER BY N_ORD DESC`;
        db.all(sql, function (err, rows) {
            callback(rows);
        });
    },

    createLIvingRoomDBData: function (date, temperature, light, noise, gas, ipAddress) {
        db.run("INSERT INTO KitchenDB(Insert_DT,Temp_NO,Cmd_NO,Noise_NO,Flare_FL,Gas_FL,IP_ID)\
                VALUES ('" + String(date) + "'\
                ," + parseInt(temperature) + "\
                ," + parseInt(light) + "\
                ," + parseInt(noise) + "\
                ," + parseInt(gas) + "\
                ,'" + String(ipAddress) + "')", function (err) {
            console.log(err);
        });
    },

    getLivingRoomDBData: function (callback) {
        let sql = `SELECT * FROM LivingRoomDB ORDER BY N_ORD DESC`;
        db.all(sql, function (err, rows) {
            callback(rows);
        });
    }

}
