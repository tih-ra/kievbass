class AddIconToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :icon, :string
  end

  def self.down
    remove_column :users, :icon
  end
end
