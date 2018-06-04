require "test_helper"
require "rails/generators/test_case"
require "able_setup/generators/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  DESTINATION = File.expand_path File.join(File.dirname(__FILE__), "..", "..", "tmp")
  FileUtils.mkdir_p(DESTINATION) unless Dir.exist?(DESTINATION)

  destination DESTINATION
  tests       AbleSetup::Generators::InstallGenerator
  setup       :prepare_destination

  def prepare_destination
    FileUtils.rm_r("#{ DESTINATION }/bin")   if Dir.exist?("#{ DESTINATION }/bin")
    FileUtils.rm_r("#{ DESTINATION }/.git")  if Dir.exist?("#{ DESTINATION }/.git")
    FileUtils.rm_r("#{ DESTINATION }/hooks") if Dir.exist?("#{ DESTINATION }/hooks")

    FileUtils.mkdir_p("#{ DESTINATION }/bin")
    FileUtils.mkdir_p("#{ DESTINATION }/hooks/pre-commit")
    FileUtils.mkdir_p("#{ DESTINATION }/.git/hooks")
  end

  def test_create_bin_files
    run_generator

    assert_file "bin/setup" do |f|
      assert_match(/bundle install/, f)
    end

    assert_file "bin/git-hook" do |f|
      assert_match(/env ruby/, f)
    end
  end

  def test_create_rubocop_file
    run_generator

    assert_file ".rubocop.yml" do |f|
      assert_match(/AllCops/, f)
    end

    assert_file "hooks/pre-commit/rubocop" do |f|
      assert_match(/bundle exec rubocop/, f)
    end
  end


  def test_create_pre_commit_script
    run_generator

    assert_file ".git/hooks/pre-commit" do |f|
      assert_match(/pre-commit/, f)
    end
  end
end
