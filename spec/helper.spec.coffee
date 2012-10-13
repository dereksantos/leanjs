describe 'helper', ->
	dom = null
	helper = null

	beforeEach ->
		dom = fixture(fixtures.simpleview)
		window.app = 
			model :
				person : lean.model
					id : 1234
					firstName : 'Derek'
					lastName : 'Santos'
					address : lean.model
						street : '123 fake street',
						city : 'Toronto'
						zip : 12345
		helper = lean.helper('simpleView', dom)
		

	afterEach ->
		delete window['app']

	
	it 'should initialize a helper object with nested element references named by id.', ->
		expect(helper.title.element.nodeName).toBe('H2')
		expect(helper.personTable.element.nodeName).toBe('TABLE')
		expect(helper.personTable.addressCell.street.element.nodeName).toBe('SPAN')
		expect(helper.personTable.addressCell.cityAndCountry.element.nodeName).toBe('SPAN')
		expect(helper.personTable.addressCell.zip.element.nodeName).toBe('SPAN')

	it 'should set helpers model object and initialize bindings', ->
		expect(helper.model.id).toBe(app.model.person.id)
		expect(helper.personTable.addressCell.model.street).toBe('123 fake street')
		expect(helper.personTable.addressCell.street.model.street).toBe('123 fake street')
		expect(helper.personTable.addressCell.cityAndCountry.model.city).toBe('Toronto')
		expect(helper.personTable.addressCell.zip.model.zip).toBe(12345)
		expect(helper.title.element.innerText).toBe('Derek Santos')