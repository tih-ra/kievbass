class Admin::UsersController < Admin::BaseController
  before_filter :login_required
#  active_scaffold :user do |c|
#    c.list.columns = [:login, :email, :created_at, :admin]
#    c.update.columns = [:login, :password, :password_confirmation, :email, :admin, :invitations]
#    c.create.columns = [:login, :password, :password_confirmation, :email, :admin, :invitations]
#  end
  layout "admin"
end
