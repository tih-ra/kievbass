class Admin::PodcastsController < Admin::BaseController
 
  before_filter :find_podcast, :only => [:edit, :update, :destroy]

  def index
    @pages, @podcasts = paginate("podcasts", :order => "podcasts.created_at DESC", :per_page => 50, :include => :user)
  end

  def create
    @podcast = Podcast.new params[:podcast]
    @podcast.is_active = params[:podcast][:is_active] # && has_role
    @podcast.save!
    redirect_to admin_podcasts_path
  end

  def update
    @podcast.attributes = params[:podcast]
    @podcast.is_active = params[:podcast][:is_active]
    @podcast.save!
    redirect_to admin_podcasts_path
  end

  def destroy
    @podcast.destroy
    redirect_to admin_podcasts_path
  end

  protected

  def find_podcast
    @podcast = Podcast.find(params[:id])
  end

end
