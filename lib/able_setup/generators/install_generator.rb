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
    end
  end
end
