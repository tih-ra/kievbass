class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :content, :text
      t.column :extended_content, :text
      t.column :created_at, :datetime
      t.column :is_active, :boolean
    end

    add_index :articles, [:is_active, :created_at], :name => "postable_content"
    add_index :articles, [:created_at], :name => "created_at_ndx"
    add_index :articles, [:user_id, :created_at], :name => "user_ndx"
  end

  def self.down
    drop_table :articles
  end
end
