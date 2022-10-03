# frozen_string_literal: true

require_relative "lib/view_component_scoped_css/version"

Gem::Specification.new do |spec|
  spec.name          = "view_component_scoped_css"
  spec.version       = ViewComponentScopedCss::VERSION
  spec.authors       = ["Masa (Aileron inc)"]
  spec.email         = ["masa@aileron.cc"]

  spec.summary       = "Provides view_component with scss in the form of css modules"
  spec.description   = "
    Inspired by the css in js component, it provides functionality to allow the same
    component-by-component implementation of styles in rails' standard component, view_components.
  "
  spec.homepage      = "https://github.com/aileron-inc/view_component_in_css"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aileron-inc/view_component_scoped_css"
  spec.metadata["changelog_uri"] = "https://github.com/aileron-inc/view_component_scoped_css/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "activesupport", ">= 6.0.0"
  spec.add_dependency "sass-embedded"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
