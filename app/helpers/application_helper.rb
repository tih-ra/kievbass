module ApplicationHelper
  def menu_image_path(condition, image_prefix, ext = "gif")
    (condition.is_a?(String) ? params[:controller] == condition : condition) ? "#{image_prefix}_active.#{ext}" : "#{image_prefix}.#{ext}"
  end

  def current_page? page
    @page && @page.name == page
  end
  
end