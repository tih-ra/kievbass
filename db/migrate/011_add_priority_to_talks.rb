class AddPriorityToTalks < ActiveRecord::Migration
  def self.up
    add_column :talks, :priority, :integer
  end

  def self.down
    remove_column :talks, :priority
  end
end
