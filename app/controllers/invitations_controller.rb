class InvitationsController < ApplicationController
  def index
      if current_user
        @users = User.find(:all, :conditions => ["invitation_id = ?", current_user.id ])
      end
  end

  def create
    invitation = Invitation.new(params[:invitation])
    invitation.save!
    if current_user
      UserNotifier.deliver_signup_notification(invitation)
      current_user = update_current_user
    end
    
    redirect_to invitations_path
    flash[:notice] = "Ваш запрос отправлен!"
  end

  
  private
  def update_current_user
    @user = User.find(session[:user])
    @user.invitations = current_user.invitations - 1
    @user.save!
    current_user = @user
  end
end
