class Admin::ArticlesController < Admin::BaseController

  before_filter :find_article, :only => [:edit, :update, :destroy]
  configure_blogs_text_editor_panel(:options=>{:lang=>"ru", :image_upload_path=>"", :album_image_function=>""})
  
  
  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 20, :order=>"created_at DESC")
  end
  
  def edit
    @article.extended_content = @article.content+'<kiebass-cut/>'+@article.extended_content
  end
  
  def update
    cut_article
    @article.update_attributes(params[:article])
    @article.save!
    redirect_to admin_articles_path
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_path
  end

  def create
    
    cut_article
    @article = Article.new(params[:article])
    @article.save!
    redirect_to admin_articles_path
  end

  protected
  def cut_article
    @cut_content =  params[:article]["extended_content"].split('<kiebass-cut/>')
    params[:article]["content"] =@cut_content[0]
    params[:article]["extended_content"] =@cut_content[1]
  end
  def find_article
    @article = Article.find(params[:id])
  end
end
