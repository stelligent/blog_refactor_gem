require 'fileutils'

module Build
  module Commit
    # Assumes certain environment variables exist (typically set by your CI/CD tool or sourced).
    class ScmPolling
      ERROR_MESSAGE = 'Ensure the %s environment variable exists'

      def initialize(store:)
        params = {}
        %w{app_name repository_url repository_branch working_directory aws_region aws_vpc aws_subnets aws_azs aws_keypair}.each do |var|
          case var
          when 'aws_region'
            params[var.to_sym] = ENV[var] || 'us-east-1'
          when 'aws_vpc'
            params[var.to_sym] = ENV[var] || 'vpc-857a3ee2'
          when 'aws_subnets'
            params[var.to_sym] = ENV[var] || 'subnet-c5a76a8c,subnet-3b233a06'
          when 'aws_azs'
            params[var.to_sym] = ENV[var] || 'us-east-1c,us-east-1b'
          when 'working_directory'
            params[var.to_sym] = ENV[var] || '.working'
          else
            params[var.to_sym] = ENV[var] || fail(ERROR_MESSAGE % [var])
          end
        end

        FileUtils.rm_r(params[:working_directory]) if File.directory?(params[:working_directory])
        git_cmd = "git clone --branch #{repository_branch} --depth 1 #{repository_url} #{working_directory}"
        system(git_cmd)

        store.put(attrib_name: "params", value: params)
        store.save
      end
    end
  end
end
