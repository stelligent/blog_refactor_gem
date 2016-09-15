require 'fileutils'

module Build
  module Commit
    class ScmPolling
      ERROR_MESSAGE = 'Ensure a %s environment variable exists'

      def initialize(store:)
        app_name = ENV['app_name'] || fail(ERROR_MESSAGE % ['app_name'])
        repository_url = ENV['repository_url'] || fail(ERROR_MESSAGE % ['repository_url'])
        repository_branch = ['repository_branch'] || fail(ERROR_MESSAGE % ['repository_branch'])
        working_directory = ENV['workspace'] || '.workspace'
        aws_region = ENV['aws_region'] || 'us-east-1'
        aws_vpc = ENV['aws_vpc'] || 'vpc-857a3ee2'
        aws_subnets = ENV['aws_subnets'] || 'subnet-c5a76a8c,subnet-3b233a06'
        aws_azs = ENV['aws_azs'] || 'us-east-1c,us-east-1b'
        aws_keypair = ENV['aws_keypair'] || fail(ERROR_MESSAGE % ['aws_keypair'])

        FileUtils.rm_r(working_directory)
        git_cmd = "git clone --branch #{repository_branch} --depth 1 #{repository_url} #{working_directory}"
        system(git_cmd)

        params = {
          "app_name": app_name,
          "repository_url": repository_url,
          "repository_branch": repository_branch,
          "working_directory": working_directory,
          "aws_region": aws_region,
          "aws_vpc": aws_vpc,
          "aws_subnets": aws_subnets,
          "aws_azs": aws_azs,
          "aws_keypair": aws_keypair
        }
        store.put(attrib_name: "params", value: params)
        store.save
      end
    end
  end
end
