leanjs
======

A lean, lightweight javascript framework.

the focus:

simplicity
performance
readability
standalone
good documentation

<div data-list="people">
	<img data-bind="${img}" data-to="src" />
	<span data-bind="${name}"></span>
	<span data-list="friends" data-bind="${name},"></span>
</div>

new DataList() {
	this.collection = collection;
	this.helpers = helpers;

}






ideas for collections

<div id="mydiv" data-model="app.model.people">

</div>

thoughts on using collections for html lists
	allow tokens in id attribute(otherwise generate one)
	clone all child nodes

things needed:
	dispose() method for all lean apis
		should be recursive

Needed documentation

api docs
browser support
dependencies
getting started
screen casts
user guide
