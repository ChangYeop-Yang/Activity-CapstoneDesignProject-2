var noize = 0;

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
		var noizeObj = {
			"noize": noize
		}
		var noizeStr = JSON.stringify(noizeObj);

		console.log(noizeStr);
		res.send(noizeStr)
		res.end();
	}

}