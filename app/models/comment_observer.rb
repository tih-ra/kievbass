class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    if comment.commentable_type == 'Talk'
      comment.commentable.last_commented = Time.now
      comment.commentable.save
    end
  end
end
