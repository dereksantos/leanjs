lean.util = (function() {
	var global = this,
		exports = {};

	exports.isElementNode = function(node) {
		return node.nodeType === 1;
	};

	exports.getObject = function(path, root) {
		var pieces = path.split('.'),
			length = pieces.length,
			i,
			obj = (root !== undefined) ? root : global;

		for(i = 0; i < length; i++) {
			obj = obj[pieces[i]];
		}
		return obj;
	};

	return exports;
}).call(this);