module.exports = {

	writeData: function (connection, message) {
		if (message.type === 'utf8') {
			return connection.sendUTF(message.utf8Data);
		}
		else if (message.type === 'binary') {
			return connection.sendBytes(message.binaryData);
		}
		else
			return connection.send(message);
		
	}

}