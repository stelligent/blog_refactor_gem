module Build
  module Acceptance
    class EnvironmentConfiguration
      def initialize(store:)
        fail 'This class MUST be inherited in order to support your custom configuration' unless EnvironmentConfiguration.descendants.any?
      end

      def self.descendants
        ObjectSpace.each_object(Class).select { |klass| klass < self }
      end
    end
  end
end
