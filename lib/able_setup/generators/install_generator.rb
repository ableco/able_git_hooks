module AbleSetup
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Create setup files"
      source_root File.expand_path("../templates", __FILE__)

      def create_setup_executable
        copy_file "setup", "bin/setup"
      end

      def create_rubocop_file
        copy_file "rubocop.yml", ".rubocop.yml"
      end

      def append_rubocop_precommit
        append_to_file ".git/hooks/precommit" do
          <<~'HOOK'
            cmd="bundle exec rubocop "
            for file in $(git diff --name-only | tr '\n' ' '); do
              cmd+="<(git show :$file) "
            done

            # Use echo $cmd to see the cmd generated
            eval $cmd
          HOOK
        end
      end
    end
  end
end
