class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table "invitations", :force => true do |t|
      t.column :email,                     :string
      t.column :activation_code,          :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :invitation_id, :integer
      t.column :about_me, :text
    end
  end

  def self.down
    drop_table "invitations"
  end
end
