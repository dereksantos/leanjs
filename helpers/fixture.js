var fixtures = {},
	fixture = function(html) {
		var dom = document.implementation.createHTMLDocument('Test Fixture');
		dom.write(html);
		return dom;
	};