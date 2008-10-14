class CommentsController < ApplicationController
  
  def create
      comment = Comment.create(params[:comment])
  	  comment.user_id = session[:user]
      comment.save!
    	@current_comment = comment	
  end
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to :back
  end
  
  def list
  end
end

