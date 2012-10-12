describe('view', function() {
	var view = lean.view();
	it('should bind a model property to an html element property', function() {
		view.bind('person.name').to('personDetails.name.text').and('personDetails.nameInput.value').usingText('Hi, my name is {name}.');


	});

});