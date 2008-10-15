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
				addthis_logo            = 'http://kievbass.com/images/logo_kievbass.png';
				addthis_logo_background = 'ffffff';
				addthis_logo_color      = 'ffffff';
				addthis_brand           = 'kievbas.com';
				addthis_options         = 'email, favorites, digg, delicious, myspace, facebook, google, twitter, more';
			</script>
			<a href=\"http://www.addthis.com/bookmark.php\" onmouseover=\"return addthis_open(this, '', '[URL]', 'FRENDID.com::#{title}')\" onmouseout=\"addthis_close()\" onclick=\"return addthis_sendto()\"><img src=\"http://s9.addthis.com/button1-share.gif\" width=\"125\" height=\"16\" border=\"0\" alt='' /></a><script type=\"text/javascript\" src=\"http://s7.addthis.com/js/152/addthis_widget.js\"></script>
			<!-- AddThis Button END -->"
  end
  def tag_cloud(tags, classes)
    return if tags.empty?
    
    max_count = tags.sort_by(&:count).last.count.to_f
    
    tags.each do |tag|
      index = ((tag.count / max_count) * (classes.size - 1)).round
      yield tag, classes[index]
    end
  end
  def new_comments_count(obj)
		subscribe = obj.user_subscribes.find_by_user_id(current_user.id)
  	unless subscribe.nil?
  	  obj.comments.count(:all, :conditions=>["created_at > ? and user_id != ?", subscribe.updated_at, current_user.id])
    else
      obj.comments.count
    end
	end
	
end
