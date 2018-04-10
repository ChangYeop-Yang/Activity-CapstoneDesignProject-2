var gas = 1;

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
		var gasObj = {
			"gas": gas
		}
		var gasStr = JSON.stringify(gasObj);


		console.log(gasStr);
		res.send(gasStr)
		res.end();
	}

}