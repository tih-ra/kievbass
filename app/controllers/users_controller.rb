class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie
  
  # render new.rhtml
  def new
    @activation = Invitation.find(:first, :conditions => ["activation_code = ?", params[:activation_code]])
    if @activation
      @user= User.new
      @user.email = @activation.email
      @user.invitation_id = @activation.invitation_id
    else
        flash[:notice] = "Не верный Activation Code!"
    end
  end

  def create
    
    @user = User.new(params[:user])
    @user.save!
    self.current_user = @user
    @activation = Invitation.find(:first, :conditions => ["email = ?", @user.email])
    @activation.destroy
    redirect_back_or_default('/')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end
  
  def change
  	@user = User.find(params[:id])
    @user.attributes = params[:user]
    @user.save!
    redirect_back_or_default('/')
  end
  
  def activate
    self.current_user = User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.activated?
      current_user.activate
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/')
  end
end
