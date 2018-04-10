var airQuality = 1;

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
		var airQualityObj = {
			"airQuality" : airQuality
		}
		var airQualityStr = JSON.stringify(airQualityObj);

		console.log(airQualityStr);
		res.send(airQualityStr)
		res.end();			
	}
}

