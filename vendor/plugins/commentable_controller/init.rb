require 'commentable_controller'
ActionController::Base.send(:include, Lancelot::CommentableController)
