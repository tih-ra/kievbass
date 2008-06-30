class AddDefaultToTalks < ActiveRecord::Migration
  def self.up
    execute 'UPDATE talks set priority=0'
    execute 'ALTER TABLE talks ALTER COLUMN priority set default 0'
  end

  def self.down
  end
end
