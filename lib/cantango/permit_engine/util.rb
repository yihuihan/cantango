require 'active_support/inflector'

module CanTango
  module PermitEngine
    module Util
      def permit_name clazz
        @name ||= clazz.to_s.demodulize.gsub(/Role/,'').gsub(/Permit$/, '').gsub(/Group/,'').underscore.to_sym
      end

      def role
        @role ||= permit_name(self.class)
      end

      def localhost_manager?
        Permits::Configuration.localhost_manager
      end
    end
  end
end