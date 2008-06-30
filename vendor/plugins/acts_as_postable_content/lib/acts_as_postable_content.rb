# ActsAsPostableContent
module Pechkinator # :)
  module Acts
    module PostableContent
      def self.included base
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_postable_content
          extend Pechkinator::Acts::PostableContent::SingletonMethods
          include Pechkinator::Acts::PostableContent::InstanceMethods
        end
      end

      module SingletonMethods
        def find_active options
          find(:all, {:conditions => active_conditions}.merge(options))
        end

        def count_active
          count(:conditions => active_conditions)
        end

        protected
        def active_conditions
          ["#{table_name}.is_active = ? AND #{table_name}.created_at < ?", true, Time.now]
        end
      end

      module InstanceMethods
        def future?
          self.created_at > Time.now
        end
      end

    end
  end
end
