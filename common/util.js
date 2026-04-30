function formatTime(time) {
	if (typeof time !== 'number' || time < 0) {
		return time
	}

	var hour = parseInt(time / 3600)
	time = time % 3600
	var minute = parseInt(time / 60)
	time = time % 60
	var second = time

	return ([hour, minute, second]).map(function(n) {
		n = n.toString()
		return n[1] ? n : '0' + n
	}).join(':')
}

function formatLocation(longitude, latitude) {
	if (typeof longitude === 'string' && typeof latitude === 'string') {
		longitude = parseFloat(longitude)
		latitude = parseFloat(latitude)
	}

	longitude = longitude.toFixed(2)
	latitude = latitude.toFixed(2)

	return {
		longitude: longitude.toString().split('.'),
		latitude: latitude.toString().split('.')
	}
}
var dateUtils = {
	UNITS: {
		'年': 31557600000,
		'月': 2629800000,
		'天': 86400000,
		'小时': 3600000,
		'分钟': 60000,
		'秒': 1000
	},
	humanize: function(milliseconds) {
		var humanize = '';
		for (var key in this.UNITS) {
			if (milliseconds >= this.UNITS[key]) {
				humanize = Math.floor(milliseconds / this.UNITS[key]) + key + '前';
				break;
			}
		}
		return humanize || '刚刚';
	},
	format: function(dateStr) {
		var date = this.parse(dateStr)
		var diff = Date.now() - date.getTime();
		if (diff < this.UNITS['天']) {
			return this.humanize(diff);
		}
		var _format = function(number) {
			return (number < 10 ? ('0' + number) : number);
		};
		return date.getFullYear() + '/' + _format(date.getMonth() + 1) + '/' + _format(date.getDate()) + '-' +
			_format(date.getHours()) + ':' + _format(date.getMinutes());
	},
	parse: function(str) { //将"yyyy-mm-dd HH:MM:ss"格式的字符串，转化为一个Date对象
		var a = str.split(/[^0-9]/);
		return new Date(a[0], a[1] - 1, a[2], a[3], a[4], a[5]);
	}
};
function formatCreateTime(create_time) {
	let createTimestamp =
			typeof create_time === 'number'
				? (create_time > 1e12 ? create_time / 1000 : create_time)
				: Math.floor(new Date(create_time.replace(/-/g, '/')).getTime() / 1000);

	let nowTimestamp = Math.floor(Date.now() / 1000);
	let diffSeconds = nowTimestamp - createTimestamp;

	if (diffSeconds < 60 * 60) {
		let minutes = Math.floor(diffSeconds / 60);
		return minutes <= 0 ? '刚刚' : `${minutes} 分钟前`;
	}
	else if (diffSeconds < 24 * 60 * 60) {
		let hours = Math.floor(diffSeconds / 3600);
		return `${hours} 小时前`;
	}
	else {
		let now = new Date();
		let postDate = new Date(createTimestamp * 1000);
		if (now.getFullYear() === postDate.getFullYear()) {
			// 同年：显示月日
			return `${(postDate.getMonth() + 1)
				.toString()
				.padStart(2, '0')}月${postDate
				.getDate()
				.toString()
				.padStart(2, '0')}日`;
		} else {
			// 不同年：显示完整年月日
			return `${postDate.getFullYear()}-${(postDate.getMonth() + 1)
				.toString()
				.padStart(2, '0')}-${postDate
				.getDate()
				.toString()
				.padStart(2, '0')}`;
		}
	}
}


export {
	formatTime,
	formatLocation,
	dateUtils,
	formatCreateTime
}
