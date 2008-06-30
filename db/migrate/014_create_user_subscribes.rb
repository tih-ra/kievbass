class CreateUserSubscribes < ActiveRecord::Migration
  def self.up
    create_table :user_subscribes do |t|
      t.column "subscribtable_id", :integer, :default => 0, :null => false
      t.column "subscribtable_type", :string, :limit => 15, :default => "", :null => false
      t.column "user_id", :integer, :default => 0, :null => false
      t.column "created_at", :datetime, :null => false
    end
  
    add_index "user_subscribes", ["user_id"], :name => "fk_subscribes_user"
  end

  def self.down
    drop_table :user_subscribes
  end
end
