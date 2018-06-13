require "rails"

module AbleScripts
  class Railtie < ::Rails::Railtie
    generators do
      require "able_scripts/generators/install_generator"
    end
  end
end
