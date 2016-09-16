module Build
  module Acceptance
    # Caller MUST override this step!
    class EnvironmentConfiguration
      def initialize(store:)
        descendants = ObjectSpace.each_object(Class).select { |klass| klass < self }
        fail unless descendants.any?
      end
    end
  end
end
