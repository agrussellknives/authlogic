module Authlogic
  module ActsAsAuthentic
    module SessionKey
      def self.included(klass)
        klass.class_eval do
          extend Config
          add_acts_as_authentic_module(Methods)
        end
      end

      module Config
        def session_key_attribute value = nil
          rw_config(:session_key_attribute, value, self.primary_key, self.primary_key)
        end
        alias_method :session_key_attribute=, :session_key_attribute
      end

      module Methods
        def self.included(klass)
          klass.class_eval do
            session_key_attribute self.primary_key
            extend ClassMethods
            include InstanceMethods
          end
        end

        module ClassMethods
          def session_key
            if acts_as_authentic_config[:session_key_attribute].respond_to? :call
              acts_as_authentic_config[:session_key_attribute].call
            else
              acts_as_authentic_config[:session_key_attribute]
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

