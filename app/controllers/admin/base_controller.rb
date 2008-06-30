class Admin::BaseController < ApplicationController
  layout "admin"
  before_filter :login_required

  protected
  def authorized?
    admin?
  end
end
