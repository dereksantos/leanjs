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
					phone : '555-555-5555'
					email : 'test@leanjs.org'
					address : lean.model
						street : '123 fake street',
						city : 'Toronto'
						country : 'Canada'
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

	it 'should set model objects on helper and nested helpers', ->
		person = app.model.person
		expect(helper.model.id).toBe(person.id)

		addressCell = helper.personTable.addressCell
		model = addressCell.model
		expect(model.street).toBe(person.address.street)

		expect(addressCell.street.model.street).toBe(person.address.street)
		expect(addressCell.cityAndCountry.model.city).toBe(person.address.city)
		expect(addressCell.cityAndCountry.model.country).toBe(person.address.country)
		expect(addressCell.zip.model.zip).toBe(person.address.zip)
		
	it 'should initiaize bindings for helper', ->
		person = app.model.person
		address = person.address

		verify = ->
			expect(helper.title.element.innerText).toBe("#{person.firstName} #{person.lastName}")

			html = helper.personTable.element.innerHTML
			expect(html).toMatch(person.phone)
			expect(html).toMatch(person.email)

			addressCell = helper.personTable.addressCell
			expect(addressCell.street.element.innerText).toBe("#{address.street},")
			expect(addressCell.cityAndCountry.element.innerText).toBe("#{address.city}, #{address.country},")
			expect(addressCell.zip.element.innerText).toBe("#{address.zip}")

		verify()

		person.set
			phone : '555-111-2222'
			email : 'fake@leanjs.org'

		person.address.set
			street : '987 not fake street'
			city : 'Miami'
			country : 'USA'
			zip : 9876

		verify()








