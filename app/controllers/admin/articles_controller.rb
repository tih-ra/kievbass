class Admin::ArticlesController < Admin::BaseController

  before_filter :find_article, :only => [:edit, :update, :destroy]
  
  
  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 20, :order=>"created_at DESC")
  end

  def update
    @article.attributes = params[:article]
    @article.save!
    redirect_to admin_articles_path
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_path
  end

  def create
    @article = Article.new(params[:article])
    @article.save!
    redirect_to admin_articles_path
  end

  protected

  def find_article
    @article = Article.find(params[:id])
  end
end
