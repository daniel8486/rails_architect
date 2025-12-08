# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_architect/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_architect_analyzer"
  spec.version       = RailsArchitect::VERSION
  spec.authors       = ["Daniel Matos"]
  spec.email         = ["eu@danieldjam.dev.br", "danielmatos404@gmail.com"]

  spec.summary       = "Analyze Rails projects for architecture, TDD, BDD, and SOLID principles"
  spec.description   = "A gem that analyzes your Rails project structure and suggests improvements " \
                       "based on architecture best practices, TDD, BDD, and SOLID principles."
  spec.homepage      = "https://github.com/8486/rails_architect"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.3.0"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ast", "~> 2.4"
  spec.add_dependency "colorize", "~> 0.8"
  spec.add_dependency "parser", "~> 3.1"
  spec.add_dependency "rails", ">= 6.0"
  spec.add_dependency "thor", "~> 1.2"

  spec.metadata["rubygems_mfa_required"] = "true"
end
