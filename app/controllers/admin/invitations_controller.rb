class Admin::InvitationsController < Admin::BaseController
  before_filter :login_required
  active_scaffold :invitations do | config |
    config.action_links.add 'activate', :label => 'Activate', :type => :record, :page => true
  end
  layout "admin"
  def activate
    invitation = Invitation.find(params[:id])
    invitation.invitation_id = current_user.id
    invitation.save!
    UserNotifier.deliver_signup_notification(invitation)
    redirect_to admin_invitations_path
  end
end
