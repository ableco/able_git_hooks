require "rails"

module AbleSetup
  class Railtie < ::Rails::Railtie
    generators do
      require "able_setup/generators/install_generator"
    end
  end
end
