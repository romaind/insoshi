// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var player;

function playerReady(obj) {
	var id = obj['id'];
	var version = obj['version'];
	var client = obj['client'];
	// alert('the videoplayer '+id+' has been instantiated');
	player = document.getElementById(id);
	// player.sendEvent('ITEM', 2);
	// player.sendEvent('PLAY');
};

Event.observe(window, 'load', observeThumbs, false);

function observeThumbs(event){
	var creationThumbs = $$('a.thumb_creation');
	creationThumbs.each(function(creation){
		var opacity = new Effect.Opacity(creation, { from: 1.0, to: 0.7, duration: 0.2 });

		creation.observe('click', playItem);
		creation.observe('mouseover', opacityTo1);
		creation.observe('mouseout', opacityTo0);

	});
};

function playItem(event) {
	event.stop();
	var element = event.element().up();
	player.sendEvent('ITEM', element.id);
};

function opacityTo1(event) {
  var element = event.element().up();
  new Effect.Opacity(element, { from: 0.7, to: 1, duration: 0.2 });
};

function opacityTo0(event) {
  var element = event.element().up();
  new Effect.Opacity(element, { from: 1, to: 0.7, duration: 0.2 });
};