class PodcastsController < ApplicationController

  def index
    @podcasts = Podcast.active_only.paginate(:page => params[:page], :per_page => 400)
  end

  def show
    @podcast = Podcast.find(params[:id])
    if logged_in?
      subscribe = @podcast.user_subscribes.find_or_create_by_user_id(current_user.id)
    	subscribe.save
    
    end
    respond_to do |format|
      format.html
    end
  end

end
