(() => {

	let DPWrapper = {};
	DPWrapper.MessageSize = 1024;
	DPWrapper.messageId = 0;

	window.SendMessage = function (namespace, type, msg) {

		DPWrapper.messageId = (DPWrapper.messageId < 65535) ? DPWrapper.messageId + 1 : 0;
		const str = JSON.stringify(msg);

		for (let i = 0; i < str.length; i++) {

			let count = 0;
			let chunk = '';

			while (count < DPWrapper.MessageSize && i < str.length) {

				chunk += str[i];

				count++;
				i++;
			}

			i--;

			const data = {
				__type: type,
				id: DPWrapper.messageId,
				chunk: chunk
			}

			if (i == str.length - 1)
				data.end = true;

			$.post('https://' + namespace + '/__chunk', JSON.stringify(data));

		}

	}

})()
