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
    FileUtils.rm_r("#{ DESTINATION }/bin") if Dir.exist?("#{ DESTINATION }/bin")
    FileUtils.mkdir_p("#{ DESTINATION }/bin")
  end

  def test_create_setup_file
    run_generator

    assert_file "bin/setup" do |f|
      assert_match(/bundle install/, f)
    end
  end

  def test_create_rubocopy_file
    run_generator

    assert_file ".rubocop.yml" do |f|
      assert_match(/AllCops/, f)
    end
  end
end
