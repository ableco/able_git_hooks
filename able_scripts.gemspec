lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "able_scripts/version"

Gem::Specification.new do |spec|
  spec.name          = "able_scripts"
  spec.version       = AbleScripts::VERSION
  spec.authors       = ["Gustavo Beathyate"]
  spec.email         = ["gustavo.bt@me.com"]

  spec.summary       = "Create base scripts and config files for Able projects"
  spec.description   = "Adds a setup script and a set of rubocop rules to a project"
  spec.homepage      = "http://able.co"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", "~> 5.2", ">= 5.2.0"

  spec.add_development_dependency "bundler",  "~> 1.16"
  spec.add_development_dependency "rake",     "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
