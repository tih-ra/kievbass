class Admin::PagesController < Admin::BaseController

  before_filter :find_page, :only => [:edit, :update, :destroy]

  def index
    @pages_of_pages, @pages = paginate("pages", :order => "name ASC", :per_page => 50)
  end

  def create
    @page = Page.create!(params[:page])
    redirect_to admin_pages_path
  end

  def preview
    @page = Page.new(params[:page])
    render :action => "../../pages/show", :layout => "site"
  end

  def update
    @page.attributes = params[:page]
    @page.save!
    redirect_to admin_pages_path
  end

  def destroy
    @page.destroy
    redirect_to admin_pages_path
  end

  protected
  def find_page
    @page = Page.find(params[:id])
  end
end
