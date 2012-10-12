var lean = {
	defaults : {
		bindable : true,
		restore : function() {
			lean.defaults.bindable = true;
		}
	}
};

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

	return model;
};