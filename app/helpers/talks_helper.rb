module TalksHelper
	def new_comments_count(talk)
		subscribe = talk.user_subscribes.find_by_user_id(current_user.id)
  	if subscribe != nil
  	  talk.comments.count(:all, :conditions=>["created_at > ? and user_id != ?", subscribe.updated_at, current_user.id])
    else
      talk.comments.count
    end
	end
end
