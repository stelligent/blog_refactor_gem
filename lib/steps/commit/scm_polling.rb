require 'fileutils'

module Build
  module Commit
    # Assumes certain environment variables exist (typically set by your CI/CD tool or sourced).
    class ScmPolling
      ERROR_MESSAGE = 'Ensure the %s environment variable exists'

      def initialize(store:)
        params = {}
        %w{app_name repository_url repository_branch working_directory aws_region aws_vpc aws_subnets aws_azs aws_keypair}.each do |var|
          params[var.to_sym] = ENV[var] || fail(ERROR_MESSAGE % [var])
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
