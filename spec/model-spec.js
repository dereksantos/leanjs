describe('model', function() {
	var testObject = {
			title : 'LeanJS',
			body : 'A simple light framework.'
		},
		model = lean.model(testObject);

	it('should initialize __fields object', function() {
		var fields = model.__fields;
		expect(fields.title).toBe(testObject.title);
		expect(fields.body).toBe(testObject.body);
	});

	it('should initialize getters and setters', function() {
		expect(model.title).toBe(testObject.title);
		expect(model.body).toBe(testObject.body);
	});

	it('should dispatch changed signal when a property changes', function() {
		var newTitle = 'Changed Title';
		spyOn(model.changed, 'dispatch');
		model.title = newTitle;
		expect(model.changed.dispatch).toHaveBeenCalledWith('title', newTitle, testObject.title);
	});

});