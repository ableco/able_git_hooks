module AbleGitHooks
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Install git hook files"
      source_root File.expand_path("../templates", __FILE__)

      def install_git_hooks
        copy_file "_do_hook", ".git/hooks/_do_hook"
        chmod ".git/hooks/_do_hook", 0755

        AbleGitHooks::SCRIPTS.each do |hook|
          create_link ".git/hooks/#{hook}", "_do_hook"
          chmod       ".git/hooks/#{hook}", 0755
        end
      end

      def install_rubocop_hooks
        copy_file "rubocop.rb", "hooks/pre-commit/rubocop.rb"
        chmod "hooks/pre-commit/rubocop.rb", 0755
      end

      def copy_rubocop_defaults
        template "rubocop.yml", "config/rubocop.yml"
      end
    end
  end
end
