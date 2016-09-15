
# rds creation first
#   will inject custom attribs into the store about the RDS instance
# chef json creation
#   read the custom store attribs
#   blend in the standard store attribs
#   make the json
#   push it into S3
#

module Build
  module Acceptance
    # Caller MUST override this step!
    class EnvironmentConfiguration
      def initialize(store:)
        # do nothing special
      end
    end
  end
end
