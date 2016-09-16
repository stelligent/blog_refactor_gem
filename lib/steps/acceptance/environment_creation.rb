require_relative '../utils/cfn'

module Build
  module Acceptance
    class EnvironmentCreation
      include BlogRefactorGem::Utils::Cfn

      def initialize(store:)
        params = store.get(attrib_name: 'params')
        stack_info = create_stack(params: params)
        params[:elb_dns_name] = stack_info.outputs.select { |output| output[:output_key] == "DNSName" }[0][:output_value]
      end

      def create_stack(params:)
        put_stack(
          region: params[:aws_region],
          name: params[:rds_stackname],
          template_url: 'https://s3.amazonaws.com/stelligent-blog/chefjson/templates/deploy-app.template.json',
          parameters: {
            VpcId: params[:aws_vpc],
            AppName: params[:app_name],
            AWSKeyPair: params[:aws_keypair],
            ASGSubnetIds: params[:aws_subnets],
            ASGAvailabilityZones: params[:aws_azs],
            ChefJsonKey: params[:chef_json_key],
            GitBranch: params[:repository_branch],
            GitUrl: params[:repository_url],
            SecurityGroupPort: params[:app_port],
          },
          tags: [
            { key: 'application', value: params[:app_name] },
            { key: 'branch', value: params[:repository_branch] }
          ]
        )
      end
    end
  end
end
