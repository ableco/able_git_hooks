lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "able_git_hooks/version"

Gem::Specification.new do |spec|
  spec.name          = "able_git_hooks"
  spec.version       = AbleGitHooks::VERSION
  spec.authors       = ["Mario Rodas", "Gustavo Beathyate"]
  spec.email         = ["mario@able.co", "gustavo.bt@able.co"]

  spec.summary       = "Creates an extensible git hooks system on rails projects"
  spec.description   = "Adds scripts in .git/hooks to call scripts in the root hooks directory"
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

  spec.add_dependency "railties", "~> 5.2",    ">= 5.2.0"
  spec.add_dependency "rubocop",  "~> 0.57.2", ">= 0.57.2"

  spec.add_development_dependency "bundler",  "~> 1.16"
  spec.add_development_dependency "rake",     "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
