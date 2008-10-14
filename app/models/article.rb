class Article < ActiveRecord::Base
  belongs_to :user
  has_many :user_subscribes, :as => :subscribtable
  validates_presence_of :title, :content
  named_scope :active_only, :conditions=>{:is_active=>true},  :order => "articles.created_at DESC", :include => [:user, :comments]
  acts_as_taggable
  
  acts_as_postable_content
  acts_as_commentable
    
end
