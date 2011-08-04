module CanTango
  module PermissionEngine
    module Selector
      class Users < Base
        attr_reader :user, :user_key

        def initialize subject
          @user = subject.user
          @user_key = user.send(subject.user_key_field)
        end

        def valid? permission
          permission == user_key
        end
      end
    end
  end
end



