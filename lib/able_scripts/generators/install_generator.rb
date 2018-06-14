module AbleScripts
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Generate scripts and config files"
      source_root File.expand_path("../templates", __FILE__)

      def copy_setup_script
        copy_file "bin/setup"
      end

      def copy_rubocop_files
        copy_file "rubocop.yml", ".rubocop.yml"
        copy_file "hooks/pre-commit/rubocop"
      end

      def install_git_hooks
        copy_file "git/hooks/_do_hook", ".git/hooks/_do_hook"
        chmod     ".git/hooks/_do_hook", 0755, verbose: false

        AbleScripts::GIT_HOOKS.each do |hook|
          create_link ".git/hooks/_do_hook", ".git/hooks/#{hook}"
        end
      end
    end
  end
end
