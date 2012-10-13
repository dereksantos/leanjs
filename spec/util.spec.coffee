describe 'util', ->
	
	

	beforeEach ->
		window.app = 
			model :
				test :
					prop1 : 'value1'
					prop2 : 'value2'

	afterEach ->
		delete window['app']

	it 'should return true when a node object is of type 1 (an element node) and false otherwise', ->
		node = nodeType : 1
		expect(lean.util.isElementNode(node)).toBe(true);
		node = nodeType : 2
		expect(lean.util.isElementNode(node)).toBe(false);


	it 'should return an object from the global scope from the specified path using dot notation', ->
		obj = lean.util.getObject('app.model.test')
		expect(obj.prop1).toBe('value1')
		expect(obj.prop2).toBe('value2')

	it 'should return an object from a specified object using dot notation', ->
		root = 
			garage :
				car :
					parts : ['engine', 'door']
		result = lean.util.getObject('garage.car.parts', root)
		expect(result.length).toBe(2)
