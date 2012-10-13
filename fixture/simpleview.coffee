fixtures.simpleview = 
"""
<div id="simpleView" data-model="app.model.person">
	<h2 id="title" data-bind="{firstName} {lastName}"></h2>
	<table id="personTable">
		<tr>
			<th>Phone #:</th>
			<td data-bind="{phone}"></td>
		</tr>
		<tr>
			<th>Address:</th>
			<td id="addressCell" data-model="app.model.person.address">
				<span id="street" data-bind="{street},"></span><br/>
				<span id="cityAndCountry" data-bind="{city}, {country},"></span><br/>
				<span id="zip" data-bind="{zip}"></span>
			</td>
		</tr>
		<tr>
			<th>Email:</th>
			<td data-bind="{email}"></td>
		</tr>
	</table>
</div>
"""