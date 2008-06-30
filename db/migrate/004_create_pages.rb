class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.column :content, :text
      t.column :name, :string
    end
    add_index :pages, :name, :name => "name_ndx"
  end

  def self.down
    drop_table :pages
  end
end
