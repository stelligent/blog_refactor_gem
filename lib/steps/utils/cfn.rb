require 'aws-sdk-core'

module BlogRefactorGem
  module Utils
    module CFN
      def get_stack(stack_name:, region:)
        # do stuff
        cfn_client ||= Aws::CloudFormation::Client.new(region: region)
        begin
          return cfn_client.describe_stacks(stack_name: stack_name).stacks.first
        rescue Aws::CloudFormation::Errors::ValidationError
          return nil
        end
      end
    end
  end
end
