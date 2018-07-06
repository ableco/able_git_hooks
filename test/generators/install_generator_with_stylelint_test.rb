require "test_helper"
require "rails/generators/test_case"
require "able_git_hooks/generators/install_generator"

class InstallGeneratorWithStylelintTest < Rails::Generators::TestCase
  include FileUtils

  DESTINATION = File.expand_path File.join(File.dirname(__FILE__), "..", "..", "tmp")

  destination DESTINATION
  tests AbleGitHooks::Generators::InstallGenerator

  def setup
    remake_dirs ".git", "hooks", "config"
    run_generator %w(--with-stylelint)
  end

  def teardown
    rm_r DESTINATION
  end

  def test_stylelint_hook_not_copied
    assert_file "hooks/pre-commit/stylelint-check.js"
  end

  def test_stylelint_config_not_copied
    assert_file ".stylelintrc"
  end

  private

  def remake_dirs(*dirs)
    FileUtils.mkdir_p(DESTINATION) unless Dir.exist?(DESTINATION)
    dirs.each do |dir|
      path = "#{DESTINATION}/#{dir}"

      rm_r path if Dir.exist?(path)
      mkdir_p path
    end
  end
end
