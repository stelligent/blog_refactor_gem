require 'aws-sdk-core'

module BlogRefactorGem
  module Utils
    module Cfn
      def Cfn.get_stack(region:, name:)
        begin
          return Aws::CloudFormation::Client.new(region: region).describe_stacks(stack_name: name).stacks.first
        rescue Aws::CloudFormation::Errors::ValidationError
          return nil
        end
      end

      def Cfn.put_stack(region:, name:, template_url:, parameters:, tags:)
        required_options = {
          stack_name: name,
          template_url: template_url,
          parameters: parameters.map { |key, value| { parameter_key: key, parameter_value: value, use_previous_value: false } }.to_a,
          capabilities: ['CAPABILITY_IAM'],
          disable_rollback: true
        }
        options = tags.nil? ? required_options : { tags: tags }.merge(required_options)
        cfn = Aws::CloudFormation::Client.new(region: region)
        cfn.create_stack(options)

        begin
          cfn.wait_until(:stack_create_complete, stack_name: name).stacks.first
        rescue Aws::Waiters::Errors::FailureStateError => error
          raise error
        end
      end
    end
  end
end
