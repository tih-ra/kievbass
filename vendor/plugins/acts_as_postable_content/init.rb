require 'acts_as_postable_content'
ActiveRecord::Base.send(:include, Pechkinator::Acts::PostableContent)
