class TalksController < ApplicationController
 before_filter :find_talk, :only => [:destroy, :update, :show]
 
 def index
 	  @current_talk = {"id"=>0}
 	  @talks = Talk.active_only.paginate(:page => params[:page], :per_page => 15)
    
	end
 
  def show
    if !session[:user]
      redirect_to talks_path
    end
    @current_user = current_user
 
    @current_talk = {"id"=>0}
 
    subscribe = @talk.user_subscribes.find_or_create_by_user_id(current_user.id)
  	@comments = @talk.comments.find(:all, :conditions=>["created_at > ? and user_id != ?", subscribe.updated_at, current_user.id])
  	subscribe.save
  end
  
  def create
    @current_talk = Talk.new(params[:talk])
    @current_talk.save!
    @talks = Talk.active_only.paginate(:page => params[:page], :per_page => 15)
    
  end
  def update
    if @talk.priority == 1
      @talk.priority = 0
    else
      @talk.priority = 1
    end
    @talk.save!
    redirect_to talks_path
  end
  def destroy
     @talk.destroy
     redirect_to talks_path
   end
   
  def update_comment
  	@talk = find_talk
  	subscribe = @talk.user_subscribes.find_or_create_by_user_id(current_user.id)
  	@comments = @talk.comments.find(:all, :conditions=>["created_at > ? and user_id != ?", subscribe.updated_at, current_user.id])
  	subscribe.save
  end
   
   private
  def find_talk
   	@talk = Talk.find(params[:id])
  end
   
end
