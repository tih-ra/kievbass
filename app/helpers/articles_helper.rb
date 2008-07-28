module ArticlesHelper
  def new_comments_count(article)
		subscribe = article.user_subscribes.find_by_user_id(current_user.id)
  	unless subscribe.nil?
  	  article.comments.count(:all, :conditions=>["created_at > ? and user_id != ?", subscribe.updated_at, current_user.id])
    else
      article.comments.count
    end
	end
end
