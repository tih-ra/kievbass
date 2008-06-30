class Page < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name
  before_validation do |page|
    page.name.gsub!(/[^a-zA-Z0-9-]+/, "-")
  end
end
