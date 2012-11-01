(function() {

	var priv = {

	};

	lean.collection = function(source) {
		return new lean.objects.Collection(source);
	};

	lean.objects.Collection = function(source) {

		this.source = source;
		this.changed = new signals.Signal();

		this.add = function(item) {
			this.source.push(item);
			this.changed.dispatch({
				action : 'add',
				item : item,
				index : this.size()
			});
		};

		this.get = function(index) {
			return this.source[index];
		};

		this.each = function(callback) {
			var length = this.source.length,
				i;
			for(i = 0; i < length; i++) {
				callback(this.source[i], length);
			}
		};

		this.merge = function(input) {
			
		};

		this.replace = function(index, item) {
			if (index < this.size()) {
				this.source[index] = item;
				this.changed.dispatch({
					action : 'replace',
					item : item,
					index : index
				});
				return item;
			}
			throw new Error('Could not replace item at index. Index ['+index+'] is out of bounds');
		};

		this.remove = function(index) {
			var item = this.source.splice(index, 1)[0];
			this.changed.dispatch({
				action : 'remove',
				item : item,
				index : index
			});
			return item;
		};

		this.size = function() {
			return this.source.length;
		}

	}

}).call(this);