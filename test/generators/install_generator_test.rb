require "test_helper"
require "rails/generators/test_case"
require "able_scripts/generators/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  DESTINATION = File.expand_path File.join(File.dirname(__FILE__), "..", "..", "tmp")

  FileUtils.mkdir_p(DESTINATION) unless Dir.exist?(DESTINATION)

  destination DESTINATION
  tests       AbleScripts::Generators::InstallGenerator

  def setup
    FileUtils.rm_r("#{DESTINATION}/bin")   if Dir.exist?("#{DESTINATION}/bin")
    FileUtils.rm_r("#{DESTINATION}/.git")  if Dir.exist?("#{DESTINATION}/.git")
    FileUtils.rm_r("#{DESTINATION}/hooks") if Dir.exist?("#{DESTINATION}/hooks")

    FileUtils.mkdir_p("#{DESTINATION}/bin")
    FileUtils.mkdir_p("#{DESTINATION}/hooks/pre-commit")
    FileUtils.mkdir_p("#{DESTINATION}/.git/hooks")

    run_generator
  end

  def test_bin_files_were_created
    assert_file "bin/setup" do |f|
      assert_match(/bundle install/, f)
    end

    assert_file "bin/git-hook" do |f|
      assert_match(/env ruby/, f)
    end
  end

  def test_rubocop_files_were_created
    assert_file ".rubocop.yml" do |f|
      assert_match(/AllCops/, f)
    end

    assert_file "hooks/pre-commit/rubocop" do |f|
      assert_match(/bundle exec rubocop/, f)
    end
  end


  def test_pre_commit_script_was_created
    assert_file ".git/hooks/pre-commit" do |f|
      assert_match(/pre-commit/, f)
    end
  end
end
