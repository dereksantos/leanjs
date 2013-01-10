leanjs
======

A lean, lightweight javascript binding framework.

A Simple Example
----------------

### Model

To set-up your model, use the lean.model method on any object.

	window.mymodel = lean.model({
		name : 'LeanJS',
		email : 'lean@js.com'
  	});


### View

To bind the model to the view, declare a data-model attribute on any tag. Also make sure you give the element an id, you'll need it later.

	<div id="myview" data-model="mymodel">
	</div>

Then, you can use the data-bind attribute to bind properties to the text node of your elements.

	<div id="myview" data-model="mymodel">
		<span data-bind="${name}, ${email}"></span>
	</div>

### The Helper Method

Lastly, call the lean.helper method and pass in the elements id.
	
	lean.helper('myview');


### The completed example

	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<title>LeanJS Example</title>
		<script src="lean.js"></script>
		<script type="text/javascript">
			window.onload = function() {
				window.mymodel = lean.model({
					name : 'LeanJS',
					email : 'lean@js.com'
			  	});

			  	var myViewHelper = lean.helper('myview'); //This trigger bindings and watch for changes.
			};
		</script>
	</head>
	<body>
		<div id="myview" data-model="mymodel">
			<span data-bind="${name}, ${email}"></span>
		</div>
	</body>
	</html>


Disclaimer: LeanJS is still under development and not complete.
