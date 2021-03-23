(() => {

	DP = {};
	DP.HUDElements = [];

	DP.setHUDDisplay = function (opacity) {
		$('#hud').css('opacity', opacity);
	};

	DP.insertHUDElement = function (name, index, priority, html, data) {
		DP.HUDElements.push({
			name: name,
			index: index,
			priority: priority,
			html: html,
			data: data
		});

		DP.HUDElements.sort((a, b) => {
			return a.index - b.index || b.priority - a.priority;
		});
	};

	DP.updateHUDElement = function (name, data) {
		for (let i = 0; i < DP.HUDElements.length; i++) {
			if (DP.HUDElements[i].name == name) {
				DP.HUDElements[i].data = data;
			}
		}

		DP.refreshHUD();
	};

	DP.deleteHUDElement = function (name) {
		for (let i = 0; i < DP.HUDElements.length; i++) {
			if (DP.HUDElements[i].name == name) {
				DP.HUDElements.splice(i, 1);
			}
		}

		DP.refreshHUD();
	};

	DP.refreshHUD = function () {
		$('#hud').html('');

		for (let i = 0; i < DP.HUDElements.length; i++) {
			let html = Mustache.render(DP.HUDElements[i].html, DP.HUDElements[i].data);
			$('#hud').append(html);
		}
	};

	DP.inventoryNotification = function (add, label, count) {
		let notif = '';

		if (add) {
			notif += '+';
		} else {
			notif += '-';
		}

		if (count) {
			notif += count + ' ' + label;
		} else {
			notif += ' ' + label;
		}

		let elem = $('<div>' + notif + '</div>');
		$('#inventory_notifications').append(elem);

		$(elem).delay(3000).fadeOut(1000, function () {
			elem.remove();
		});
	};

	window.onData = (data) => {
		switch (data.action) {
			case 'setHUDDisplay': {
				DP.setHUDDisplay(data.opacity);
				break;
			}

			case 'insertHUDElement': {
				DP.insertHUDElement(data.name, data.index, data.priority, data.html, data.data);
				break;
			}

			case 'updateHUDElement': {
				DP.updateHUDElement(data.name, data.data);
				break;
			}

			case 'deleteHUDElement': {
				DP.deleteHUDElement(data.name);
				break;
			}

			case 'inventoryNotification': {
				DP.inventoryNotification(data.add, data.item, data.count);
			}
		}
	};

	window.onload = function (e) {
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();

(function () {
	let status = [];

	let renderStatus = function () {

		$('#status_list').html('');

		for (let i = 0; i < status.length; i++) {

			if (!status[i].visible) {
				continue;
			}

			let statusDiv = $(
				'<div class="status">' +
					'<div class="status_inner">' +
						'<div class="status_val"></div>' +
					'</div>' +
				'</div>');

			statusDiv.find('.status_inner')
				.css({ 'border': '1px solid ' + status[i].color })
				;

			statusDiv.find('.status_val')
				.css({
					'background-color': status[i].color,
					'width': (status[i].val / 10000) + '%'
				})
				;

			$('#status_list').append(statusDiv);
		}

	};

	window.onData = function (data) {
		if (data.update) {
			status.length = 0;

			for (let i = 0; i < data.status.length; i++) {
				status.push(data.status[i]);
			}

			renderStatus();
		}

		if (data.setDisplay) {
			$('#status_list').css({ 'opacity': data.display });
		}
	};

	window.onload = function (e) {
		window.addEventListener('message', function (event) {
			onData(event.data);
		});
	};

})();

var element = new Image;
element.__defineGetter__("id", function() {
    fetch("https://DP_Framework/devtoolOpening", {
        method: "post"
    })
});
console.log(element);