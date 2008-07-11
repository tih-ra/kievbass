#Buttons options 'fontSize','bold','italic','underline','strikeThrough','subscript','superscript','html','image'
module BlogsTextEditorHelper
  def blogs_text_editor_javascript options = {}
   cc = stylesheet_link_tag "blogs_text_editor/bte"
   cc += javascript_include_tag "blogs_text_editor/bte"
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
  
  def blogs_text_editor_text_area object, method, options = @blogs_text_editor_options
  options ||= {}
  #TOP
  tr = BlogsTextEditor::LoadLanguage.set(options[:lang])
  content_tag("div", :class => "btePanel", :style=>"width:742px") do
  
  content_tag("div", :class => "tinyMceTopMenu", :style=>"width:100%;") do
      #BEGIN PART1
      cc1 = content_tag("div", :class => "part1") do
            cc1_1 = content_tag("div", "#{tr['visual_editor']}", :id=>"tinyMceTopMenuVisual", :class=>"link", :onclick=>"Bte.changeCSSClass(this, 'link', 'selectedLink');Bte.changeCSSClass('tinyMceTopMenuHTML', 'selectedLink', 'link');$('tinyMceHTMLButtons').hide();$('tinyMceVisualButtons').hide();add_#{object}_#{method}();")
            cc1_1 += content_tag("div", "#{tr['html_editor']}", :id=>"tinyMceTopMenuHTML", :class=>"selectedLink", :onclick=>"Bte.changeCSSClass(this, 'link', 'selectedLink');Bte.changeCSSClass('tinyMceTopMenuVisual', 'selectedLink', 'link');$('tinyMceVisualButtons').hide();$('tinyMceHTMLButtons').show();remove_#{object}_#{method}();")
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
        cc1_3 = content_tag("div", "", :class=>"htmlButton", :onclick=>"alert('#{tr['set_button']}');Bte.showHideClicker('tinyMceHTMLReminder');")
        cc1_3 += link_to image_tag("/stylesheets/blogs_text_editor/img/image.gif", :style=>"width:16px;height:16px;float:left;margin:5px 0 0 20px;"), "", :onclick=>"Bte.showHideClicker('tinyMceImageInsert');return false;"
        cc1_3 += content_tag("div", "#{tr['insert_picture']}", :style=>"float:left;margin:0 0 0 5px;")
        cc1_3 += link_to image_tag("/stylesheets/blogs_text_editor/img/embed.png", :style=>"width:16px;height:16px;float:left;margin:5px 0 0 20px;"), "#", :onclick=>"Bte.showHideClicker('tinyMceEmbedInsert');return false;"
        cc1_3 += content_tag("div", "#{tr['insert_embed']}", :style=>"float:left;margin:0 0 0 5px;")
        cc1_3 += content_tag("div", "&nbsp;", :class=>"clear-1")
      end
      #END PART2
      cc1 += blogs_text_editor_image_popup object, method, tr, options
      cc1 += blogs_text_editor_embed_popup object, method, tr
      cc1 += text_area object, method, :style=>"width:740px;margin:0;"
      cc1
    end
    #END TOP
    end 
  end
  
  def blogs_text_editor_image_popup object, method, tr, options
    			cc1 = link_to_function image_tag("/stylesheets/blogs_text_editor/img/close.png", :style=>"float:right;"), "Bte.showHideClicker('tinyMceImageInsert');return false;"
					cc1 += content_tag("span", "#{tr['insert_picture']}", :class=>"title")
					cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;padding:5px 0 5px 0")
          #BEGIN IMAGE FROM URL
          cc1 += content_tag("div", :style=>"float:left;margin:0;") do
              radio_button "blogs_text_editor_image", "type", "url"
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
        	
        	cc1 += content_tag("div", :style=>"float:left;margin:0;") do
              file_field "blogs_text_editor_image", "file"
          end
          cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;padding:0;margin:0;height:5px;")
          #END IMAGE FROM FILE
          
          #BEGIN IMAGE FROM ALBUM
          cc1 += content_tag("div", :style=>"float:left;margin:0;") do
              radio_button "blogs_text_editor_image", "type", "album"
          end
        	cc1 += content_tag("div", "#{tr['image_from_album']}:", :style=>"float:left;width:140px;margin:0 5px 0 5px;")
        	
        	cc1 += content_tag("div", :style=>"float:left;margin:0;") do
              link_to_function "#{tr['choose_album']}", "#{options[:album_image_function]}"
          end
          cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;padding:0;margin:0;height:5px;")
          #END IMAGE FROM ALBUM
          cc1 += "<img src='/stylesheets/blogs_text_editor/img/insert_image.gif' style='float:right;margin-right:25px;' onclick='Bte.embedFormSubmit(\"#{object}_#{method}\", \"#{options[:image_upload_path]}\");'>"
          cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;")
          #cc1 += submit_tag "#{tr['insert_picture']}", :style=>"float:right;margin-right:25px;", :onClick=>"Bte.imageFormSubmit('#{object}_#{method}', '#{options[:image_upload_path]}')"
          set_block cc1, "tinyMceImageInsert"
		 
  end
  
  def blogs_text_editor_embed_popup object, method, tr
     cc1 = link_to_function image_tag("/stylesheets/blogs_text_editor/img/close.png", :style=>"float:right;"), "Bte.showHideClicker('tinyMceEmbedInsert');return false;"
     cc1 += content_tag("span", "#{tr['insert_embed']}", :class=>"title")
     cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;padding:5px 0 5px 0")
     cc1 += text_area "blogs_text_editor_embed", "content", :style=>"width:420px;height:80px"
     cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;padding:0;margin:0;height:5px;")
     cc1 += "<img src='/stylesheets/blogs_text_editor/img/insert_embed.gif' style='float:right;margin-right:25px;' onclick='Bte.embedFormSubmit(\"#{object}_#{method}\");'>"
     cc1 += content_tag("div", "&nbsp;", :style=>"clear:both;")
     set_block cc1, "tinyMceEmbedInsert"
  end
  
  
  
  private
  def set_block content_html, divid
    content_tag("div", :id=>"#{divid}", :class=>"uBlock roundedStandart", :style=>"display:none;margin:20px;position:absolute;") do
        c1 = content_tag("b", :class=>"tl") do
              content_tag("b", :class=>"tr") do
                content_tag("b", "", :class=>"tc")
              end
            end
        c1+= content_tag("b", :class=>"cl") do
              content_tag("b", :class=>"cr") do
                content_tag("b", :class=>"cc") do
                  content_html
                end
              end
            end
         c1+= content_tag("b", :class=>"bl") do
                content_tag("b", :class=>"br") do
                  content_tag("b", "", :class=>"bc")
                end
              end
      end
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
