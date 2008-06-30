class Admin::InvitationsController < Admin::BaseController
  before_filter :login_required
  def index
     @invitations = Invitation.paginate(:page => params[:page], :per_page => 20, :order=>"created_at DESC")
  end
  def activate
    @invitation = Invitation.find(params[:id])
    @invitation.invitation_id = current_user.id
    @invitation.save!
    UserNotifier.deliver_signup_notification(@invitation)
  end
  def show
    @invitation = Invitation.find(params[:id])
    render :layout=>false
  end
end
