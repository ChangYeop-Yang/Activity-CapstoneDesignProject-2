module.exports = {

	readData: function (message) {
		if (message.type === 'utf8') {
			return message.utf8Data;
		}
		else if (message.type === 'binary') {
			return message.binaryData;
		}
		else return message;
	}

}