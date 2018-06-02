module AbleSetup
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Create setup files"
      source_root File.expand_path("../templates", __FILE__)

      def create_project_setup_file
        copy_file "setup", "bin/setup"
      end

      def create_rubocop_files
        copy_file "rubocop.yml", "config/rubocop.yml"
        copy_file ".rubocop",    ".rubocop"
      end
    end
  end
end
