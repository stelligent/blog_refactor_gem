module Build
  module Commit
    class CommitTrigger
      def initialize(store:)
        store.put(attrib_name: 'revision', value: "asf67srewe8osdf" )
        store.save
      end
    end

    class StaticAnalysis
      def initialize(store:)
        store.put(attrib_name: 'tests', value: [ "run_foodcritic" ] )
        run_foodcritic
        store.save
      end
      def run_foodcritic
        puts "Running foodcritic..."
      end
    end

    class UnitTests
      def initialize(store:)
        tests = store.get(attrib_name: 'tests')
        store.put(attrib_name: 'tests', value: (tests.nil? ? [] : tests) << "run_unit_tests" )
        run_unit_tests
        store.save
      end
      def run_unit_tests
        puts "Running unit tests..."
      end
    end

    class LocalAcceptanceTests
      def initialize(store:)
        puts "#{self.class} initialized"
      end
    end
  end

  module Acceptance
    class AcceptanceArtifact
      def initialize(store:)
        puts "#{self.class} initialized"
      end
    end

    class AcceptanceEnvironment
      def initialize(store:)
        puts "#{self.class} initialized"
      end
    end

    class AcceptanceTests
      def initialize(store:)
        puts "#{self.class} initialized"
      end
    end

    class SmokeTests
      def initialize(store:)
        puts "#{self.class} initialized"
      end
    end
  end
end
