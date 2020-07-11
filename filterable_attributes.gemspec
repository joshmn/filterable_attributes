require_relative 'lib/filterable_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = "filterable_attributes"
  spec.version       = FilterableAttributes::VERSION
  spec.authors       = ["Josh Brody"]
  spec.email         = ["git@josh.mn"]

  spec.summary       = "Filterable attributes for ActiveModelSerializers."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/joshmn/filterable_attributes"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]
  spec.add_dependency 'active_model_serializers'
end
