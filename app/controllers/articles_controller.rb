class ArticlesController < ApplicationController

  def index
    @articles = Article.active_only.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @current_user = current_user
    @article = find_article
    subscribe = @article.user_subscribes.find_or_create_by_user_id(current_user.id)
  	@comments = @article.comments.find(:all, :conditions=>["created_at > ? and user_id != ?", subscribe.updated_at, current_user.id])
  	subscribe.save
    respond_to do |format|
      format.html { }
    end
  end
  
   
   private
   def find_article
   		@article = Article.find(params[:id], :include=>[:comments, :user])
   end
end
