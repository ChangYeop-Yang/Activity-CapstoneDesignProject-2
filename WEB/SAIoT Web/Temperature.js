var temperature = 0;

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
		var temperatureObj = {
			"temperature": temperature
		}
		var temperatureStr = JSON.stringify(noizeObj);

		console.log(temperatureStr);
		res.send(temperature)
		res.end();
	}

}