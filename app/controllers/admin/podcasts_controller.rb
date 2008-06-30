class Admin::PodcastsController < Admin::BaseController
 
  before_filter :find_podcast, :only => [:edit, :update, :destroy]

  def index
    @podcasts = Podcast.all.paginate(:page => params[:page], :per_page => 50)
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
