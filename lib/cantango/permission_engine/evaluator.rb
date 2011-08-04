module CanTango
  module PermissionEngine
    class Evaluator
      attr_reader :ability, :rule

      include CanTango::Rules

      def initialize ability, rule
        @ability = ability
        @rule = rule
        safe_rules!
      end

      def evaluate! user
        @user = user
        instance_eval rule.can if rule.can?
        instance_eval rule.cannot if rule.cannot?
      end

      def rules
        ability.send :rules
      end
     
      def user
        @user
      end

      def safe_rules!
        rule.can.gsub!(/(User|UserAccount)/,'::\1') if rule.can?
        rule.cannot.gsub!(/(User|UserAccount)/,'::\1') if rule.cannot?
      end
    end
  end
end