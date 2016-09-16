require 'open3'

module BlogRefactorGem
  module Utils
    module Cmd
      def Cmd.execute_shell(command:)
        stdout, stderr, status = Open3.capture3(command)
        fail(stderr.readlines.join('')) unless status.exitstatus == 0
        stdout.readlines.join('')
      end
    end
  end
end
