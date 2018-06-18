module AbleGitHooks
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Install git hook files"
      source_root File.expand_path("../templates", __FILE__)

      def copy_rubocop_files
        copy_file "rubocop.yml",  ".rubocop.yml"
        copy_file "rubocop_hook", "hooks/pre-commit/rubocop"
        chmod     "0755",         "hooks/pre-commit/rubocop"
      end

      def install_git_hooks
        copy_file "_do_hook", ".git/hooks/_do_hook"
        chmod     "0755",     ".git/hooks/_do_hook"

        AbleGitHooks::SCRIPTS.each do |hook|
          create_link ".git/hooks/#{hook}", "_do_hook"
          chmod       "0755",               ".git/hooks/#{hook}"
        end
      end
    end
  end
end
