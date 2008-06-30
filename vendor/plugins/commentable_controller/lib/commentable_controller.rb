# CommentableController
module Lancelot
  module CommentableController
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def commentable
        before_filter :comment_initialization, :only => :create
        
        include Lancelot::CommentableController::Actions
      end
    end
    
    module Actions
      def create
        current_user.comments << @comment
        respond_to do |format|
          format.html { redirect_to :back }
          format.js
        end
      end
      
      private
        def comment_initialization
          @commentable = commentable_klass.find(params[commentable_param])
          @comment = @commentable.comments.build(params[:comment])
        end
        
        def commentable_param
          params.keys.detect {|key| key =~ /\_id$/}.to_sym
        end
        
        def commentable_table
          commentable_param.to_s.sub(/\_id/, '').pluralize
        end
        
        def commentable_klass
          commentable_table.singularize.classify.constantize
        end
    end
  end
end
