class PodcastsController < ApplicationController

  def index
    @podcasts = Podcast.active_only.paginate(:page => params[:page], :per_page => 400)
  end

  def show
    @podcast = Podcast.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

end
