# frozen_string_literal: true

module ViewComponentScopedCss
  #
  # Resolve css module naming after loading and compiling scss files to provide final css
  #
  class Loader
    # class_attribute :compile_options, default: { source_map: true, style: { output: :compressed } }

    def initialize(view_component_class)
      @identifier = view_component_class.name.sub("::Component", "").underscore.split("/").join('\:\:')
      @path = "app/components#{view_component_class.virtual_path}.scss"
    end

    def call
      ViewComponentScopedCss::Compiler.new(path: @path, identifier: @identifier).call
    rescue Sass::CompileError => e
      raise "scss[#{@path}] #{e.message}"
    end
  end
end
