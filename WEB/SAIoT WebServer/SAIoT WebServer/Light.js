var light = 0;
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
		var lightObj = {
			"light": light
		}
		var lightStr = JSON.stringify(lightObj);
		console.log(lightStr);
		res.send(lightStr)
		res.end();
	}
}