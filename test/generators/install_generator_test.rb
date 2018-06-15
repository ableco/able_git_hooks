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
    remake_dirs ".git", "hooks"
    run_generator
  end

  def test_rubocop_files_were_copiead
    assert_file ".rubocop.yml" do |f|
      assert_match(/AllCops/, f)
    end

    assert_file "hooks/pre-commit/rubocop" do |f|
      assert_match(/bundle exec rubocop/, f)
    end
  end

  def test_git_hook_was_copied
    assert_file ".git/hooks/_do_hook" do |f|
      assert_match(/for hook in/, f)
    end
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
