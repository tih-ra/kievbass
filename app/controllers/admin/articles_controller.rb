class Admin::ArticlesController < Admin::BaseController

  before_filter :find_article, :only => [:edit, :update, :destroy]

  def index
    @pages, @articles = paginate(:articles, :per_page => 50, :order => "articles.created_at DESC", :include => :user)
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
