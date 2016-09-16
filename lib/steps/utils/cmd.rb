module BlogRefactorGem
  module Utils
    module Cmd
      def Cmd.execute_shell(command:)
        stdout, stderr, status = Open3.popen(command)
        fail(stderr.readlines.join('')) unless status.exitstatus == 0
        stdout.readlines.join('')
      end
    end
  end
end
