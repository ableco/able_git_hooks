module AbleGitHooks
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Install git hook files"
      source_root File.expand_path("../templates", __FILE__)

      class_option :with_stylelint, type: :boolean, default: false, description: "Include the default configuration for stylelint"


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

      def install_eslint_hooks
        copy_file "eslint-check.js", "hooks/pre-commit/eslint-check.js"
        chmod "hooks/pre-commit/eslint-check.js", 0755
      end

      def copy_eslint_defaults
        copy_file "eslintrc.json", ".eslintrc.json"
      end

      def copy_prettier_defaults
        copy_file "prettierrc", ".prettierrc"
      end

      def install_stylelint_hooks
        if options["with_stylelint"]
          copy_file "stylelint-check.js", "hooks/pre-commit/stylelint-check.js"
          chmod "hooks/pre-commit/stylelint-check.js", 0755
        end
      end

      def copy_stylelint_defaults
        if options["with_stylelint"]
          copy_file "stylelintrc", ".stylelintrc"
        end
      end
    end
  end
end
