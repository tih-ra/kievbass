/**
 * $Id: editor_plugin_src.js 324 2007-11-01 12:58:49Z spocke $
 *
*/

/**
 * $Id: editor_plugin_src.js 201 2007-02-12 15:56:56Z spocke $
 *
 * @author Tih_ra
 * @copyright Copyright © 2004-2007, Tih_ra, All rights reserved.
 */

// Load plugin specific language pack
tinymce.PluginManager.requireLangPack('suser');

(function() {
	tinymce.create('tinymce.plugins.Suser', {
		/**
		 * Constructor for the example plugin.
		 *
		 * @param {tinymce.Editor} ed Editor instance that the plugin is initialized in.
		 * @param {string} url Absolute URL to where the plugin is located.
		 */
		init : function(ed, url) {
			// Register the command so that it can be invoked by using tinyMCE.activeEditor.execCommand('mceExample');
			ed.addCommand('mceSuser', function() {
				var user_login = prompt("Ник юзера:","");
				if (!user_login) return false;
				ed.execCommand('mceInsertContent', 0, "user:"+user_login+":");
			});

			// Register example button
			/*
			ed.addButton('hrcut', 'hrcut.desc', 'mceHrcut', {
				image : url + '/images/hrcut.gif'
			});*/
			ed.addButton('suser', {
				title : 'suser.desc',
				cmd : 'mceSuser'
			});
			
		},

		/**
		 * Returns information about the plugin as a name/value array.
		 * The current keys are longname, author, authorurl, infourl and version.
		 *
		 * @return {Object} Name/value array containing information about the plugin.
		 */
		getInfo : function() {
			return {
				longname : 'S User',
				author : 'Tihra',
				authorurl : 'http://tih-ra.name',
				infourl : 'http://seepla.com',
				version : "1.0"
			};
		}
	});

	// Register plugin
	tinymce.PluginManager.add('suser', tinymce.plugins.Suser);
})();
