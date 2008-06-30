class CreatePodcasts < ActiveRecord::Migration
  def self.up
    create_table :podcasts do |t|
      t.column :title, :string
      t.column :description, :text
      t.column :size, :integer  # file size in bytes
      t.column :content_type, :string   # mime type, ex: application/mp3
      t.column :filename, :string   # sanitized filename
      t.column :created_at, :datetime
      t.column :is_active, :boolean
    end
    add_index :podcasts, [:is_active, :created_at], :name => "active_date_ndx"
  end

  def self.down
    drop_table :podcasts
  end
end
