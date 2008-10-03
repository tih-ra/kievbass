module ApplicationHelper
  def menu_image_path(condition, image_prefix, ext = "gif")
    (condition.is_a?(String) ? params[:controller] == condition : condition) ? "#{image_prefix}_active.#{ext}" : "#{image_prefix}.#{ext}"
  end

  def current_page? page
    @page && @page.name == page
  end
  def set_button button_type
    image_tag "icons/#{button_type}.png"
  end
  
  def add_this_button(title)
    	"<!-- AddThis Button BEGIN -->
			<script type='text/javascript'>
				addthis_pub  = 'kievbass';
				addthis_logo            = 'http://frendid.com/images/logo_kievbass.png';
				addthis_logo_background = 'ffffff';
				addthis_logo_color      = 'ffffff';
				addthis_brand           = 'kievbas.com';
				addthis_options         = 'email, favorites, digg, delicious, myspace, facebook, google, twitter, more';
			</script>
			<a href=\"http://www.addthis.com/bookmark.php\" onmouseover=\"return addthis_open(this, '', '[URL]', 'FRENDID.com::#{title}')\" onmouseout=\"addthis_close()\" onclick=\"return addthis_sendto()\"><img src=\"http://s9.addthis.com/button1-share.gif\" width=\"125\" height=\"16\" border=\"0\" alt='' /></a><script type=\"text/javascript\" src=\"http://s7.addthis.com/js/152/addthis_widget.js\"></script>
			<!-- AddThis Button END -->"
  end
  
end
