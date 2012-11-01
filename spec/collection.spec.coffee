###
to be added in future versions:

collection.indexOn('id', 'name')
collection.searchFor('something')

collection.extract('id').join(',');
collection.extract('id', 'name');

###
describe 'collection', ->
	
	collection = null
	source = null

	beforeEach ->
		source = []

		source.push
			name : 'John Doe',
			email : 'john@example.com'

		source.push
			name : 'Jane Doe',
			email : 'jane@example.com'

		collection = lean.collection(source)



	it 'should construct a Collection object with the correct properties and methods', ->		
		expect(collection.source).toBe(source)
		expect(collection.size()).toBe(2)
		expect(collection.changed).toBeDefined()

	it 'should add an item and be able to retrieve it using the get function', ->
		collection.add
			name : 'test'
			email : 'test@example.com'

		item = collection.get 2
		expect(collection.size()).toBe(3)
		expect(item.name).toBe('test')
		expect(item.email).toBe('test@example.com')

	it 'should remove an existing item in the collection using the remove function', ->
		item = collection.remove(0)
		expect(collection.size()).toBe(1)
		expect(item.name).toBe('John Doe')
		expect(item.email).toBe('john@example.com')

	it 'should return null when remove is called with an out of bounds index', ->
		item = collection.remove(100)
		expect(item).toBe(undefined)

	it 'should replace an existing item at the specified index', ->
		collection.replace(1, {
			name : 'replaced',
			email : 'replaced@example.com'
		})
		item = collection.get(1)
		expect(item.name).toBe('replaced')
		expect(item.email).toBe('replaced@example.com')

	it 'should throw an index out of bounds error when trying to replace an index that is not in the source array', ->
		tester = ->
			collection.replace(100, {})

		expect(tester).toThrow()

	it 'should dispatch the changed signal with the add action when an item is added', ->
		collection.changed.addOnce (info) ->
			expect(info.action).toBe('add')
			expect(info.item.name).toBe('test')
			expect(info.item.email).toBe('test@test.com')
			expect(info.index).toBe(3)

		collection.add
			name : 'test'
			email : 'test@test.com'

	it 'should dispatch the changed signal with the remove action when an item is removed', ->
		collection.changed.addOnce (info) ->
			expect(info.action).toBe('remove')
			expect(info.item.name).toBe('John Doe')
			expect(info.item.email).toBe('john@example.com')
			expect(info.index).toBe(0)

		collection.remove(0)

	it 'should dispatch the changed signal with the replace action when an item is replaced', ->
		collection.changed.addOnce (info) ->
			expect(info.action).toBe('replace')
			expect(info.item.name).toBe('replaced')
			expect(info.item.email).toBe('replaced@example.com')
			expect(info.index).toBe(1)

		collection.replace 1,
			name : 'replaced'
			email : 'replaced@example.com'





	


		