(function() {

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

					if (binding.srcProp === key) {
						bindings = binding.bindings;
						length = bindings.length;
						for(i = 0; i < length; i++) {
							item = bindings[i];
							item.dst[item.dstProp] = value;
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
		var object = {};

		object.changed = new signals.Signal();
		
		object.watch = function(modelProp, callback) {
			this.changed.add(function(key, value, old) {
				if (key === modelProp) {
					callback(value, old);
				}
			});
		};

		object.bind = function(property) {
	 		var binding = new lean.objects.Binding();
	 		return binding.from(this, property);
		};

		object.set = function(keyOrObject, value) {
			var objectKey;
			if (value !== undefined && value !== null) {
				this.update(keyOrObject, value);
			} else {
				for(objectKey in keyOrObject) {
					this.update(objectKey, keyOrObject[objectKey]);
				}
			}
		};

		object.update = function(key, newValue) {
			var oldValue = this[key];
			if (oldValue !== newValue) {
				this[key] = newValue;
				this.changed.dispatch(key, newValue, oldValue);
			}
		};

		object.set(definition);

		return object;
	}
}).call(this);