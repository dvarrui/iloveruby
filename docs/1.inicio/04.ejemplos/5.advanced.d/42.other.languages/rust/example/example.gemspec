# frozen_string_literal: true

require_relative "lib/example/version"

Gem::Specification.new do |spec|
  spec.name = "example"
  spec.version = Example::VERSION
  spec.authors = ["David Vargas"]
  spec.email = ["dvarrui@protonmail.com"]

  spec.summary = "Write a short summary, because RubyGems requires one."
  spec.description = "Write a longer description or delete this line."
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  spec.extensions = ["ext/example/extconf.rb"]
  # needed until rubygems supports Rust support is out of beta
  spec.add_dependency "rb_sys", "~> 0.9.39"
  # only needed when developing or packaging your gem
  spec.add_development_dependency "rake-compiler", "~> 1.2.0"


  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
