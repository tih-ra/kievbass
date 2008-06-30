class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  layout proc {|controller|
    controller.params[:format].nil? || controller.params[:format] == "html" ? "site" : nil
  }
  before_filter :define_sidebar

  helper_method :admin?

  def admin?
    current_user && current_user.admin
  end

  protected

  def rescue_action(exception)
    exception.is_a?(ActiveRecord::RecordInvalid) ? render_invalid_record(exception.record) : super
  end

  def render_invalid_record(record)
    render :action => (record.new_record? ? 'new' : 'edit')
  end

  def define_sidebar
    @sidebar_name = "sidebar"
  end

end
