module AbleScripts
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Generate scripts and config files"
      source_root File.expand_path("../templates", __FILE__)

      def copy_bin_files
        copy_file "setup",    "bin/setup"
        copy_file "git-hook", "bin/git-hook"
      end

      def copy_rubocop_files
        copy_file "rubocop.yml", ".rubocop.yml"
        copy_file "rubocop-hook", "hooks/pre-commit/rubocop"
      end

      def install_git_hooks
        AbleScripts::GIT_HOOKS.each do |hook|
          create_file ".git/hooks/#{hook}" do
            <<~HOOK
              #!/bin/sh
              ruby bin/git-hook #{hook}
            HOOK
          end
        end
      end
    end
  end
end
