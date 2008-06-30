/**
 * $Id: editor_plugin_src.js 324 2007-11-01 12:58:49Z spocke $
 *
*/

/**
 * $Id: editor_plugin_src.js 201 2007-02-12 15:56:56Z spocke $
 *
 * @author Moxiecode
 * @copyright Copyright © 2004-2007, Moxiecode Systems AB, All rights reserved.
 */

// Load plugin specific language pack
tinymce.PluginManager.requireLangPack('hrcut');

(function() {
	tinymce.create('tinymce.plugins.HrCut', {
		init : function(ed, url) {
			// Register commands
			ed.addCommand('mceHrcut', function() {
				ed.execCommand('mceInsertContent', 0, "<hr class='cut' />");
			});

			// Register buttons
			ed.addButton('hrcut', {
				title : 'hrcut.hrcut_desc',
				cmd : 'mceHrcut'
			});

			ed.onNodeChange.add(function(ed, cm, n) {
				cm.setActive('advhr', n.nodeName == 'HR');
			});

			ed.onClick.add(function(ed, e) {
				e = e.target;

				if (e.nodeName === 'HR')
					ed.selection.select(e);
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
				longname : 'Hr cut',
				author : 'Tihra',
				authorurl : 'http://tinymce.moxiecode.com',
				infourl : 'http://wiki.moxiecode.com/index.php/TinyMCE:Plugins/example',
				version : "1.0"
			};
		}
	});

	// Register plugin
	tinymce.PluginManager.add('hrcut', tinymce.plugins.HrCut);
})();
