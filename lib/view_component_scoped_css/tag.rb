# frozen_string_literal: true

module ViewComponentScopedCss
  #
  # style tag for outputting inline css
  #
  class Tag
    def initialize(component_class)
      @component_class = component_class
    end

    def call
      "<style data-component-name=\"#{@component_class.name}\">#{css}</style>".html_safe
    end

    def css
      ViewComponentScopedCss::Loader.new(@component_class).call.html_safe
    end
  end
end
