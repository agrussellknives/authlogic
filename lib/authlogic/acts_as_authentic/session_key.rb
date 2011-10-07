module Authlogic
  module ActsAsAuthentic
    module SessionKey
      def self.included(klass)
        klass.class_eval do
          extend Config
          add_act_as_authentic_module(Methods)
        end
      end

      module Config
        def session_key value = nil
          rw_config(:session_key, value, proc { self.class.primary_key })
        end
        alias_method :session_key=, :session_key
      end

      module Methods
        def self.included(klass)
          klass.class_eval do
            extend ClassMethods
            include InstanceMethods
          end
        end

        module ClassMethods
          def session_key
            if self.session_key.respond_to? :call
              self.session_key.call
            else
              self.session_key
            end
          end
        end

        module InstanceMethods
          def session_key
            self.class.session_key
          end
        end
      end
    end
  end
end
 
