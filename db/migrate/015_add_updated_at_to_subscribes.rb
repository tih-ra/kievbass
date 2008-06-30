class AddUpdatedAtToSubscribes < ActiveRecord::Migration
  def self.up
    add_column :user_subscribes, :updated_at, :datetime, :null => false
  end

  def self.down
    remove_column :user_subscribes, :updated_at
  end
end
