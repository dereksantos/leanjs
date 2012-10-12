describe('defaults', function() {
	it('should have defaults set initially, be able to change them and restore them', function() {
		var defaults = lean.defaults;
		expect(defaults.bindable).toBe(true);
		
		defaults.bindable = false;
		expect(defaults.bindable).toBe(false);
		
		defaults.restore();
		expect(defaults.bindable).toBe(true);
	});
});