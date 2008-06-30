function talkAutoUpdate(id) {
	new Ajax.Request('update_comment/'+id);
	window.setTimeout('talkAutoUpdate('+id+')',4000);
}
//Event.observe(window, 'load', talkAutoUpdate, false);