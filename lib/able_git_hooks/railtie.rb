require "rails"

module AbleGitHooks
  class Railtie < ::Rails::Railtie
    generators do
      require "able_git_hooks/generators/install_generator"
    end
  end
end
