var fire = 0;

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
		var fireObj = {
			"fire": fire
		}
		var fireStr = JSON.stringify(fireObj);


		console.log(fireStr);
		res.send(fireStr)
		res.end();
	}

}