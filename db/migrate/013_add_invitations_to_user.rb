class AddInvitationsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :invitations, :integer, :default=>2
    add_column :users, :invitation_id, :integer, :default=>0
  end

  def self.down
     remove_column :users, :invitation_id
     remove_column :users, :invitations
  end
end
