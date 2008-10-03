class Podcast < ActiveRecord::Base
  
  belongs_to :user
  has_many :user_subscribes, :as => :subscribtable
  has_attachment :storage => :file_system, :size => 0..300.megabytes
  acts_as_postable_content
  acts_as_commentable
  validates_as_attachment
  validates_length_of :title, :maximum => 255
  validates_presence_of :title
  validates_presence_of :description
  named_scope :active_only, :conditions=>{:is_active=>true},  :order => "podcasts.created_at DESC", :include => [:user]
  


end
