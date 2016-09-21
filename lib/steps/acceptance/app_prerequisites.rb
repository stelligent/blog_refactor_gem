module Build
  module Acceptance
    class AppPrerequisites
      def initialize(store:)
        fail 'This class MUST be inherited in order to support your custom configuration' unless AppPrerequisites.descendants.any?
      end

      def self.descendants
        ObjectSpace.each_object(Class).select { |klass| klass < self }
      end
    end
  end
end
