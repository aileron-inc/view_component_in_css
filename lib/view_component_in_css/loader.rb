# frozen_string_literal: true

module ViewComponentInCss
  #
  # Resolve css module naming after loading and compiling scss files to provide final css
  #
  class Loader
    # class_attribute :compile_options, default: { source_map: true, style: { output: :compressed } }

    def initialize(view_component_class)
      @view_component_class = view_component_class
      @identifier = view_component_class.name.sub("::Component", "").underscore.split("/").join('\:\:')
      @path = "app/components#{view_component_class.virtual_path}.scss"
      @css = Sass.compile(@path).css
    rescue Sass::CompileError => e
      raise "scss[#{@path}] #{e.message}"
    end

    def call
      @css.lines.map do |line|
        case line
        when /.*module\((.*)\)/
          css_class_name = [".viewcomponent", @identifier, ::Regexp.last_match(1)].compact.join('\:\:')
          line.gsub(Regexp.last_match[0], css_class_name)
        else
          line
        end
      end.join
    end
  end
end
