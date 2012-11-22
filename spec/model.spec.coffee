describe 'model', ->
	model = null
	expectation = 
		title : 'LeanJS',
		body : 'A simple light framework.'

	beforeEach ->
		model = lean.model(expectation)

	afterEach ->
		model = null

	it 'should initialize properties', ->
		for key,value of expectation
			expect(model[key]).toBe(value)

	it 'should dispatch changed signal when a property changes', ->
		newTitle = 'Changed Title'
		spyOn(model.changed, 'dispatch')
		model.set 'title', newTitle
		expect(model.changed.dispatch).toHaveBeenCalledWith('title', newTitle, 'LeanJS')

	it 'should automatically update a property of destination object with a value from a model object', ->
		destination = output : ''
		model.bind('title').to(destination, 'output')
		expect(destination.output).toBe('LeanJS');
		model.set 'title', 'Binding'
		expect(destination.output).toBe('Binding')

	it 'should call a specified function when a property has changed using watch()', ->
		watcher = (newValue, oldValue) ->
			expect(newValue).toBe('new value')
			expect(oldValue).toBe('LeanJS')
			expect(model.title).toBe('new value')

		model.watch('title', watcher)
		model.set 'title', 'new value'

	it 'should update multiple properties and dispatch changed signal for each', ->
		spyOn(model.changed, 'dispatch')

		model.set
			title : 'Title2'
			body : 'Body2'

		expect(model.changed.dispatch).toHaveBeenCalledWith('title', 'Title2', 'LeanJS')
		expect(model.changed.dispatch).toHaveBeenCalledWith('body', 'Body2', 'A simple light framework.')
		expect(model.title).toBe('Title2')
		expect(model.body).toBe('Body2')



