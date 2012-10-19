describe 'collection', ->
	
	it 'should construct a Collection object with the correct properties and methods', ->
		array = []

		array.push
			name : 'John Doe',
			email : 'john@example.com'

		array.push
			name : 'Jane Doe',
			email : 'jane@example.com'

		collection = lean.collection(array)
		
		expect(collection.source).toBe(array);
		expect(collection.size()).toBe(2);
		expect(collection.changed).toBeDefined();

		