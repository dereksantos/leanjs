
lean.objects.Model = function(definition) {

	this.changed = new signals.Signal();
	this.__fields = {};

	this.define = function(definition) {
		var property,
			model = new lean.objects.Model();

		for(property in definition) {
			this.__fields[property] = definition[property];

			Object.defineProperty(this, property, {
				get : (function(key) {
					return function() {
						return this.__fields[key];
					};
				}).call(this, property),
				set : (function(key) {
					return function(value) {
						var old = this.__fields[key];
						this.__fields[key] = value;
						this.changed.dispatch(key, value, old);
					};
				}).call(this, property)
			});
		}
	}

	this.watch = function(modelProp, callback) {
		this.changed.add(function(key, value, old) {
			if (key === modelProp) {
				callback(value, old);
			}
		});
	};

 	this.bind = function(property) {
 		var binding = new lean.objects.Binding();
 		return binding.from(this, property);
	}
};

lean.objects.Binding = function() {

	this.src = {};
	this.srcProp = '';
	this.bindings = [];

	this.from = function(src, srcProp) {
		this.src = src;
		this.srcProp = srcProp;

		this.src.changed.add((function(binding) {
			return function(key, value, old) {
				var item,
					bindings,
					length,
					i;

				console.log(" ");
				console.log("[====changed====]");
				console.log('args: ' + [key, value, old].join(', '));
				console.log('src: ' + [binding.src, binding.srcProp].join(', '));

				if (binding.srcProp === key) {
					bindings = binding.bindings;
					length = bindings.length;
					for(i = 0; i < length; i++) {
						item = bindings[i];
						console.log('dst: ' + [item.dst, item.dstProp].join(', '));
						console.log('before: ' + item.dst[item.dstProp]);
						item.dst[item.dstProp] = value;
						console.log('after: ' + item.dst[item.dstProp]);
					}
				}
			};
		})(this));

		return this;
	}

	this.to = function(dst, dstProp) {
		this.bindings.push({
			dst : dst,
			dstProp : dstProp
		});
		dst[dstProp] = this.src[this.srcProp];
		return this;
	}

}

lean.model = function(definition) {
	var model = new lean.objects.Model();
	model.define(definition);		
	return model;
}