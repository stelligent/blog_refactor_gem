require 'fileutils'
require_relative '../utils/cmd'

module Build
  module Commit
    # Assumes certain environment variables exist (typically set by your CI/CD tool or sourced).
    class ScmPolling
      ERROR_MESSAGE = 'Ensure the %s environment variable exists'

      def initialize(store:)
        params = {}
        %w{app_name repository_url repository_branch working_directory aws_region aws_vpc aws_subnets aws_azs aws_keypair app_port}.each do |var|
          case var
          when 'aws_region'
            params[var.to_sym] = ENV[var] || 'us-east-1'
          when 'aws_vpc'
            params[var.to_sym] = ENV[var] || 'vpc-857a3ee2'
          when 'aws_subnets'
            params[var.to_sym] = ENV[var] || 'subnet-c5a76a8c,subnet-3b233a06'
          when 'aws_azs'
            params[var.to_sym] = ENV[var] || 'us-east-1c,us-east-1b'
          when 'repository_branch'
            params[var.to_sym] = ENV[var] || 'master'
          when 'working_directory'
            params[var.to_sym] = ENV[var] || '.working'
          when 'app_port'
            params[var.to_sym] = ENV[var] || '80'
          else
            params[var.to_sym] = ENV[var] || fail(ERROR_MESSAGE % [var])
          end
        end

        FileUtils.rm_r(params[:working_directory]) if File.directory?(params[:working_directory])
        output = BlogRefactorGem::Utils::Cmd.execute_shell(
          command: "git clone --branch #{params[:repository_branch]} --depth 1 #{params[:repository_url]} #{params[:working_directory]}"
        )
        puts output

        store.put(attrib_name: "params", value: params)
        store.save
      end
    end
  end
end
