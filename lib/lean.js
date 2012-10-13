var lean = {
	defaults : {
		bindable : true,
		restore : function() {
			lean.defaults.bindable = true;
		}
	}
};

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
			console.log(obj);
			obj = obj[pieces[i]];
		}
		return obj;
	};

	return exports;
}).call(this);

lean.model = function(definition) {
	var property,
		model = {
			__fields : {},
			changed : new signals.Signal()
		};

	for(property in definition) {
		model.__fields[property] = definition[property];

		Object.defineProperty(model, property, {
			get : (function(key) {
				return function() {
					return this.__fields[key];
				};
			}).call(model, property),
			set : (function(key) {
				return function(value) {
					var old = this.__fields[key];
					this.__fields[key] = value;
					this.changed.dispatch(key, value, old);
				};
			}).call(model, property)
		});
	}

	model.bind = function(modelProp) {
		var binding = {
			to : function(obj, prop) {
				model.changed.add(function(key, value, old) {
					if (key === modelProp) {
						obj[prop] = value;
					}
				});
				obj[prop] = model[modelProp];
			}
		};
		return binding;
	};

	model.watch = function(modelProp, callback) {
		model.changed.add(function(key, value, old) {
			if (key === modelProp) {
				callback(value, old);
			}
		});
	};

	return model;
};

lean.helper = (function() {
	var methods = {},
		global = this;

	methods.create = function(elementId, dom) {
		var doc = (dom !== undefined && dom !== null) ? dom : document,
			root = doc.getElementById(elementId),
			helper = {};

		if (root !== undefined && root !== null) {
			helper.element = root;
			methods.assignModel(helper);
			methods.process(helper, root);		
		}
		return helper;
	};

	methods.assignModel = function(helper, parent) {
		if (helper.element.hasAttribute('data-model')) {
			helper.model = lean.util.getObject(helper.element.getAttribute('data-model'));
		} else if (parent !== undefined && parent !== null && parent.model !== undefined && parent.model !== null) {
			helper.model = parent.model;
		}
	};

	methods.attachBinding = function(helper) {
		if (helper.model !== undefined && helper.element.hasAttribute('data-bind')) {
			//helper.model.bind(helper.element.getAttribute('data-bind')).to(helper.element, 'text');
			//TODO:
		}
	};

	methods.process = function(helper, parentNode) {
		var nodes, 
			length,
			i;

		if (lean.util.isElementNode(parentNode)) {
			nodes = parentNode.childNodes;
			length = nodes.length;
			for(var i = 0; i < nodes.length; i++) {
				methods.processChildNode(helper, nodes.item(i));
			}
		}
	};

	methods.processChildNode = function(helper, childNode) {
		var id,
			childHelper;

		if (lean.util.isElementNode(childNode)) {
			if (childNode.hasAttribute('id')) {
				childHelper = {
					element : childNode
				}
				id = childNode.getAttribute('id');
				helper[id] = childHelper;
				methods.assignModel(childHelper, helper);
				methods.process(childHelper, childNode);
			} else {
				methods.process(helper, childNode);
			}
		}
	};

	return methods.create;
}).call(this);


