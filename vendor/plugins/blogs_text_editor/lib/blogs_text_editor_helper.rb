#Buttons options 'fontSize','bold','italic','underline','strikeThrough','subscript','superscript','html','image'
module BlogsTextEditorHelper
  def blogs_text_editor_javascript options = {}
   cc = stylesheet_link_tag "blogs_text_editor/bte"
   cc += javascript_include_tag "blogs_text_editor/bte"
   cc += set_swf_uploader @blogs_text_editor_options[:image_upload_path]
   text_areas = ""
   text_panels = ""
   options.each do |key, value|
    if value.is_a?(Hash)
      value.each do |vkey, vvalue|
        text_panels += set_panel_js_function vkey, vvalue
      end
    else  
      text_areas += set_editor_js_functions key, value
    end
   end unless options.empty?
   cc += javascript_tag text_panels
   cc += javascript_tag "bkLib.onDomLoaded(function() { #{text_areas} });"
  end
  
  def blogs_text_editor_text_area object, method, obj_params = {}, options = @blogs_text_editor_options
  options ||= {}
  
  #TOP
  tr = BlogsTextEditor::LoadLanguage.set(options[:lang])
  content_tag("div", :class => "btePanel", :style=>obj_params[:style]) do
  
  content_tag("div", :class => "tinyMceTopMenu", :style=>"width:100%;") do
      #BEGIN PART1
      cc1 = content_tag("div", :class => "part1") do
            cc1_1 = content_tag("div", "#{tr['visual_editor']}", :id=>"tinyMceTopMenuVisual", :class=>"link", :onclick=>"$('#{object}_#{method}').setStyle({width:'940px'});Bte.changeCSSClass(this, 'link', 'selectedLink');Bte.changeCSSClass('tinyMceTopMenuHTML', 'selectedLink', 'link');$('tinyMceHTMLButtons').hide();$('tinyMceVisualButtons').hide();add_#{object}_#{method}();")
            cc1_1 += content_tag("div", "#{tr['html_editor']}", :id=>"tinyMceTopMenuHTML", :class=>"selectedLink", :onclick=>"$('#{object}_#{method}').setStyle({width:'930px'});Bte.changeCSSClass(this, 'link', 'selectedLink');Bte.changeCSSClass('tinyMceTopMenuVisual', 'selectedLink', 'link');$('tinyMceVisualButtons').hide();$('tinyMceHTMLButtons').show();remove_#{object}_#{method}();")
            cc1_1 +=content_tag("div", "&nbsp;", :class=>"empty")
      end
      #END PART1
      #BEGIN BUTTONS
      cc1 += content_tag("div", :class => "part2", :id=>"tinyMceVisualButtons", :style=>"display:none;") do
        content_tag("div", "&nbsp;", :class=>"clear-1")
      end
      #END BUTTONS
      #BEGIN PART2
      cc1 += content_tag("div", :id=>"tinyMceHTMLButtons", :class=>"part2", :style=>"display:block;") do
        #cc1_3 = content_tag("div", "", :class=>"htmlButton", :onclick=>"alert('#{tr['set_button']}');Bte.showHideClicker('tinyMceHTMLReminder');")
        cc1_3 = link_to image_tag("/stylesheets/blogs_text_editor/img/image.gif", :style=>"width:16px;height:16px;float:left;margin:5px 0 0 20px;cursor: pointer;"), "", :onclick=>"Bte.showHideClicker('tinyMceImageInsert');$('blogs_text_editor_image_url').value='';return false;"
        cc1_3 += content_tag("div", "#{tr['insert_picture']}", :style=>"float:left;margin:0 0 0 5px;", :onclick=>"Bte.showHideClicker('tinyMceImageInsert');$('blogs_text_editor_image_url').value='';return false;")
        cc1_3 += link_to image_tag("/stylesheets/blogs_text_editor/img/embed.png", :style=>"width:16px;height:16px;float:left;margin:5px 0 0 20px;cursor: pointer;"), "#", :onclick=>"Bte.showHideClicker('tinyMceEmbedInsert');$('blogs_text_editor_embed_content').value='';return false;"
        cc1_3 += content_tag("div", "#{tr['insert_embed']}", :style=>"float:left;margin:0 0 0 5px;", :onclick=>"Bte.showHideClicker('tinyMceEmbedInsert');$('blogs_text_editor_embed_content').value='';return false;")
        cc1_3 += link_to image_tag("/stylesheets/blogs_text_editor/img/cut.png", :style=>"width:16px;height:16px;float:left;margin:5px 0 0 20px;cursor: pointer;"), "#", :onclick=>"Bte.cutToArea(\"#{object}_#{method}\"); return false;"
        cc1_3 += content_tag("div", "cut", :style=>"float:left;margin:0 0 0 5px;", :onclick=>"Bte.cutToArea(\"#{object}_#{method}\"); return false;")
        cc1_3 += content_tag("div", "", :class=>"clear")
      end
      #END PART2
      cc1 += blogs_text_editor_image_popup object, method, tr, options
      cc1 += blogs_text_editor_embed_popup object, method, tr
      cc1 += text_area object, method, obj_params 
      cc1
    end
    #END TOP
    end 
  end
  
  def blogs_text_editor_image_popup object, method, tr, options
    			cc1 = link_to_function image_tag("/stylesheets/blogs_text_editor/img/close.png", :style=>"float:right;", :class=>"icon"), "Bte.showHideClicker('tinyMceImageInsert');$('blogs_text_editor_image_url').value='';return false;"
					#cc1 += content_tag("span", "#{tr['insert_picture']}", :class=>"title")
					cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;padding:5px 0 5px 0")
          #BEGIN IMAGE FROM URL
          cc1 += content_tag("div", :style=>"float:left;margin:0;") do
              radio_button "blogs_text_editor_image", "type", "url", :checked=>"checked"
          end
        	cc1 += content_tag("div", "#{tr['image_from_url']}:", :style=>"float:left;width:140px;margin:0 5px 0 5px;")
        	
        	cc1 += content_tag("div", :style=>"float:left;margin:0;") do
              text_field "blogs_text_editor_image", "url"
          end
          cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;padding:0;margin:0;height:5px;")
          #END IMAGE FROM URL
          #BEGIN IMAGE FROM FILE
          cc1 += content_tag("div", :style=>"float:left;margin:0;") do
              radio_button "blogs_text_editor_image", "type", "file"
          end
        	cc1 += content_tag("div", "#{tr['image_from_file']}:", :style=>"float:left;width:140px;margin:0 5px 0 5px;")
        	
          cc1 += content_tag("div", :id=>"bte_flashUI") do
        	  cc2 = "<image id='btnBrowse' src='/stylesheets/blogs_text_editor/img/select_photo.gif' onclick='bte_fileBrowse.apply(bte_swfu)' style='padding:0;margin:0' />"
        	  cc2 += "&nbsp;<input type='text' id='bte_txtFileName' disabled='true' style='border:none;background:#fff;width:110px;margin-top:5px;padding:0;vertical-align:top;' />"
            cc2 += content_tag("div", "<img src='/stylesheets/blogs_text_editor/img/preloader.gif'>", :id=>"bte_preloader", :style=>"display:none;")
            cc2 += content_tag("div", "", :id=>"fsUploadProgress", :class=>"flash", :style=>"display:none;")
        	  cc2 += "<input type='hidden' name='hidFileID' id='hidFileID' value='' />"
        	  cc2
        	end  
        	#cc1 += content_tag("div", :style=>"float:left;margin:0;") do
          #    file_field "blogs_text_editor_image", "file"
          #end
          
          cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;padding:0;margin:0;height:5px;")
          #END IMAGE FROM FILE
          
          #BEGIN IMAGE FROM ALBUM
          cc1 += content_tag("div", :style=>"float:left;margin:0;") do
              radio_button "blogs_text_editor_image", "type", "album"
          end
        	cc1 += content_tag("div", "#{tr['image_from_album']}:", :style=>"float:left;width:140px;margin:0 5px 0 5px;")
        	
        	cc1 += content_tag("div", :style=>"float:left;margin:0;") do
              link_to_function "#{tr['choose_album']}", "#{options[:album_image_function]} $('tinyMceImageInsert').hide();"
          end
          cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;padding:0;margin:0;height:5px;")
          #END IMAGE FROM ALBUM
          cc1 += "<img src='/stylesheets/blogs_text_editor/img/insert_image.gif' style='float:right;margin-right:25px;' onclick='Bte.imageFormSubmit(\"#{object}_#{method}\", \"#{options[:image_upload_path]}\");'>"
          cc1 += content_tag("div", "", :class=>"clear")
          #cc1 += submit_tag "#{tr['insert_picture']}", :style=>"float:right;margin-right:25px;", :onClick=>"Bte.imageFormSubmit('#{object}_#{method}', '#{options[:image_upload_path]}')"
          set_bte_block cc1, "tinyMceImageInsert", "#{tr['insert_picture']}" 
		 
  end
  
  def blogs_text_editor_embed_popup object, method, tr
     cc1 = link_to_function image_tag("/stylesheets/blogs_text_editor/img/close.png", :style=>"float:right;", :class=>"icon"), "Bte.showHideClicker('tinyMceEmbedInsert');$('blogs_text_editor_embed_content').value='';return false;"
     #cc1 += content_tag("span", "#{tr['insert_embed']}", :class=>"title")
     cc1 += content_tag("div", "Скопируйте/вставте  embed-код  с Youtube, Myspace, Flickr и других ресурсов.", :style=>"font-weight:normal;")
     cc1 += content_tag("div", "", :class=>"clear")
     cc1 += text_area "blogs_text_editor_embed", "content", :style=>"width:460px;height:80px"
     cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;padding:0;margin:0;height:5px;")
     cc1 += "<img src='/stylesheets/blogs_text_editor/img/insert_embed.gif' style='float:right;margin-right:25px;' onclick='Bte.embedFormSubmit(\"#{object}_#{method}\");'>"
     cc1 += content_tag("div", "", :class=>"clear")
     set_bte_block cc1, "tinyMceEmbedInsert", "#{tr['insert_embed']}"
  end
  
  
  
  private
  def set_bte_block content_html, divid, title
    content_tag("div", :id=>"#{divid}", :class=>"uBlock mainColumnBlock", :style=>"width:515px;display:none;margin:20px;position:absolute;") do
        c1 = content_tag("div", :class=>"tl") do
              content_tag("div", :class=>"tr") do
                content_tag("div", title, :class=>"tc")
              end
            end
        c1+= content_tag("div", :class=>"cl") do
              content_tag("div", :class=>"cr") do
                content_tag("div", :class=>"cc") do
                  content_html
                end
              end
            end
         c1+= content_tag("div", :class=>"bl") do
                content_tag("div", :class=>"br") do
                  content_tag("div", "", :class=>"bc")
                end
              end
      end
  end
  
  def set_swf_uploader url
    "<link href='/stylesheets/blogs_text_editor/bte_swfuploader.css' rel='stylesheet' type='text/css' />
    <script type='text/javascript' src='/javascripts/blogs_text_editor/swf_upload/swfupload.js'></script>
    <script type='text/javascript' src='/javascripts/blogs_text_editor/swf_upload/swfupload.graceful_degradation.js'></script>
    <script type='text/javascript' src='/javascripts/blogs_text_editor/swf_upload/fileprogress.js'></script>
    <script type='text/javascript' src='/javascripts/blogs_text_editor/swf_upload/handler.js'></script>
    <script type='text/javascript'>
      
      var bte_swfu;
    	Event.observe(window, 'load', function() {
    	 	bte_swfu = new SWFUpload({
    			// Backend settings
    			upload_url: '#{url}',	// Relative to the SWF file, you can use an absolute URL as well.
    			file_post_name: 'Bte_filedata',
    			
    			file_size_limit : '153700',	// 10 MB
    			file_types : '*.*',	// or you could use something like: '*.doc;*.wpd;*.pdf',
    			file_types_description : 'All Files',
    			file_upload_limit : '0', // Even though I only want one file I want the user to be able to try again if an upload fails
    			file_queue_limit : '1', // this isn't needed because the upload_limit will automatically place a queue limit

    			// Event handler settings
    			swfupload_loaded_handler : bte_swfUploadLoaded,

    			//file_dialog_start_handler : fileDialogStart,		// I don't need to override this handler
    			file_queued_handler : bte_fileQueued,
    			file_queue_error_handler : bte_fileQueueError,
    			file_dialog_complete_handler : bte_fileDialogComplete,

    			//upload_start_handler : uploadStart,	// I could do some client/JavaScript validation here, but I don't need to.
    			upload_progress_handler : bte_uploadProgress,
    			upload_error_handler : bte_uploadError,
    			upload_success_handler : bte_uploadSuccess,
    			upload_complete_handler : bte_uploadComplete,

    			// Flash Settings
    			flash_url : '/javascripts/blogs_text_editor/swf_upload/swfupload_f9.swf',	// Relative to this file

    			// UI settings
    			swfupload_element_id : 'bte_flashUI',		// setting for the graceful degradation plugin
    			degraded_element_id : 'degradedUI',

    			custom_settings : {
    				progress_target : 'fsUploadProgress'
    				//upload_successful : true
    			},

    			// Debug settings
    			debug: false
    		});

    	});
    </script>"

    
  end
  
  def set_panel_js_function key, value
    " var area_#{key};
    function add_#{key}() {
    	area_#{key} = #{set_editor_js_functions key, value}
    }
    function remove_#{key}() {
    	area_#{key}.removeInstance('#{key}');
    }"
  end
  
  def set_editor_js_functions key, value
    if value=="instance"
      "new nicEditor().panelInstance('#{key}');"
    elsif value=="full"
      "new nicEditor({fullPanel : true}).panelInstance('#{key}');"
    else
      "new nicEditor({buttonList : [#{value}]}).panelInstance('#{key}');"
    end
  end
end
