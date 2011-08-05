module CanTango
  class Configuration
    class User
      include Singleton

      def unique_key_field
        @unique_key_field || :email
      end

      def unique_key_field= key
        raise ArgumentError, "Not a valid key" unless key.kind_of_label?
        @unique_key_field = key
      end

      def relations
        [:owner, :author, :writer, :user]
      end
    end
  end
end

