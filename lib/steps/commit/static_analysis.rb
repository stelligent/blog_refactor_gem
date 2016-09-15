module Build
  module Commit
    class StaticAnalysis
      def initialize(store:)
        params = store.get(attrib_name: "params")
        execute_foodcritic(
          working_directory: params[:working_directory],
          app_name: params[:app_name]
        )
      end

      def execute_foodcritic(working_directory:, app_name:)
        Dir.chdir(working_directory) do
          puts "Running foodcritic on pipelines/cookbooks/#{app_name}..."
          `foodcritic -t ~FC001 "pipelines/cookbooks/#{app_name}" -P`
        end
      end
    end
  end
end
