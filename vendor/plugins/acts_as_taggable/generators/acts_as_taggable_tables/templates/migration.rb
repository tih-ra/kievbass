class AddActsAsTaggableTables < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
    end

    add_index :tags, :name

    create_table :taggings do |t|
      t.integer :tag_id, :taggable_id
      t.string :taggable_type
    end

    add_index :taggings, [:tag_id, :taggable_type, :tag_id]
    add_index :taggings, [:taggable_id, :taggable_type, :tag_id]
  end

  def self.down
    drop_table :tags
    drop_table :taggings
  end
end
