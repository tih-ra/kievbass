class AddIndexAndUserToPodcast < ActiveRecord::Migration
  def self.up
    add_column :podcasts, :user_id, :integer
    add_index :podcasts, [:user_id, :created_at], :name => "user_ndx"
    add_index :podcasts, [:created_at], :name => "created_ndx"
  end

  def self.down
    remove_index :podcasts, :name => "user_ndx"
    remove_index :podcasts, :name => "created_ndx"
    remove_column :podcasts, :user_id
  end
end
