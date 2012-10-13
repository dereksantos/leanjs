describe 'model', ->
	model = null
	expectation = 
		title : 'LeanJS',
		body : 'A simple light framework.'

	beforeEach ->
		model = lean.model(expectation)

	afterEach ->
		model = null

	it 'should initialize __fields object', ->
		for key,value of expectation
			expect(model.__fields[key]).toBe(value)

	it 'should initialize getters and setters', ->
		for key,value of expectation
			expect(model[key]).toBe(value)

	it 'should dispatch changed signal when a property changes', ->
		newTitle = 'Changed Title'
		spyOn(model.changed, 'dispatch')
		model.title = newTitle
		expect(model.changed.dispatch).toHaveBeenCalledWith('title', newTitle, expectation.title)

	it 'should automatically update a property of destination object with a value from a model object', ->
		destination = output : ''
		model.bind('title').to(destination, 'output')
		expect(destination.output).toBe('LeanJS');
		model.title = 'Binding'
		expect(destination.output).toBe('Binding')

	it 'should call a specified function when a property has changed using watch()', ->
		watcher = (newValue, oldValue) ->
			expect(newValue).toBe('new value')
			expect(oldValue).toBe('LeanJS')
			expect(model.title).toBe('new value')

		model.watch('title', watcher)
		model.title = 'new value'
