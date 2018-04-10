var humidity = 0;

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
		var humidityObj = {
			"humidity": humidity
		}
		var humidityStr = JSON.stringify(humidityObj);

		console.log(humidityStr);
		res.send(humidityStr)
		res.end();
	}

}