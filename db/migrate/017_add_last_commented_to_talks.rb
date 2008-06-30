class AddLastCommentedToTalks < ActiveRecord::Migration
  def self.up
    add_column :talks, :last_commented, :datetime
  end

  def self.down
    remove_column :talks, :last_commented
  end
end
