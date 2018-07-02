require "test_helper"
require "rails/generators/test_case"
require "able_git_hooks/generators/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  include FileUtils

  DESTINATION = File.expand_path File.join(File.dirname(__FILE__), "..", "..", "tmp")

  FileUtils.mkdir_p(DESTINATION) unless Dir.exist?(DESTINATION)

  destination DESTINATION
  tests       AbleGitHooks::Generators::InstallGenerator

  def setup
    remake_dirs ".git", "hooks", "config"
    run_generator
  end

  def test_rubocop_hooks_were_copied
    assert_file "hooks/pre-commit/rubocop" do |f|
      assert_match(/bundle exec rubocop/, f)
    end
  end

  def test_git_hook_was_copied
    assert_file ".git/hooks/_do_hook" do |f|
      assert_match(/for hook in/, f)
    end
  end

  def test_rubocop_config_was_copied
    assert_file "config/rubocop.yml" do |f|
      assert_match(/AllCops/, f)
    end
  end

  def test_eslint_hook_were_copied
    assert_file "hooks/pre-commit/eslint-check.js"
  end

  def test_eslint_config_was_copied
    assert_file ".eslintrc.json"
  end

  def test_stylelint_hook_not_copied
    assert_no_file "hooks/pre-commit/stylelint-check.js"
  end

  def test_stylelint_config_not_copied
    assert_no_file ".stylelintrc"
  end

  private

  def remake_dirs(*dirs)
    dirs.each do |dir|
      path = "#{DESTINATION}/#{dir}"

      rm_r    path if Dir.exist?(path)
      mkdir_p path
    end
  end
end
