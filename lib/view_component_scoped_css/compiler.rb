# frozen_string_literal: true

module ViewComponentScopedCss
  #
  # compiling scss files to provide final css
  #
  class Compiler
    def initialize(path:, identifier:)
      @identifier = identifier
      @css = Sass.compile(path).css
    rescue Sass::CompileError => e
      raise "scss[#{path}] #{e.message}"
    end

    def call
      @css.lines.map do |line|
        case line
        when /:module\((.*?)\)/
          css_class_name = [".viewcomponent", @identifier, ::Regexp.last_match(1)].compact.join('\:\:')
          line.gsub(Regexp.last_match[0], css_class_name)
        else
          line
        end
      end.join
    end
  end
end
