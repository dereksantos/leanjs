describe 'defaults', ->

	it 'should have defaults set initially, be able to change them and restore them', ->
		assert = (value) ->
			expect(lean.defaults.bindable).toBe value

		assert true
		
		lean.defaults.bindable = false;
		assert false
		
		lean.defaults.restore();
		assert true