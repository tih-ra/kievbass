class Talk < ActiveRecord::Base
belongs_to :user
has_many :comments, :as => :commentable, :dependent => :destroy 
has_many :user_subscribes, :as => :subscribtable
validates_presence_of :title, :content
named_scope :active_only, :conditions=>{:is_active=>true},  :order => "talks.priority DESC, talks.last_commented DESC, talks.created_at ASC", :include => [:user]


  acts_as_postable_content
  acts_as_commentable
end
