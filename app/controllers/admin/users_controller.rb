class Admin::UsersController < Admin::BaseController
  before_filter :login_required
  before_filter :find_user, :only=>[:edit, :update, :destroy]
  
  def index
    @users = User.paginate(:page => params[:page], :per_page => 100, :order=>"created_at DESC")
  end
 
  def edit
  end
 
  def update
    @user.update_attributes(params[:user])
    redirect_to admin_users_path
  end
  
  def destroy
    @user.destroy
    redirect_to admin_users_path
  end
  
  private
  def find_user
    @user = User.find(params[:id])
  end
end
