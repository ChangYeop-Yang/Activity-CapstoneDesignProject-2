var rfid = 0;

module.exports = {

	setData: function (req, res) {
		/*
		if (message.type === 'utf8') {
			return message.utf8Data;
		}
		else if (message.type === 'binary') {
			return message.binaryData;
		}
		else
			return message;
		*/
	},

	getData: function (req, res) {
		var rfidObj = {
			"rfid": rfid
		}
		var rfidStr = JSON.stringify(rfidObj);

		console.log(rfidStr);
		res.send(rfidStr)
		res.end();
	}

}