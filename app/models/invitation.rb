require 'digest/sha1'
class Invitation < ActiveRecord::Base
  before_save :make_activation_code
  
  protected
  def make_activation_code
    return if invitation_id.blank?
    self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )[0..10]
  end
end
