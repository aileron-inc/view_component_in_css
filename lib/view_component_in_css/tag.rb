# frozen_string_literal: true

module ViewComponentInCss
  #
  # style tag for outputting inline css
  #
  class Tag
    def initialize(view_component)
      @view_component = view_component
    end
    attr_reader :view_component

    def call
      view_component.tag.style(component_css, data: { module: self.class.name })
    end

    def component_style
      view_component.raw(
        ViewComponentInCss::Loader.new(view_component.class).call
      )
    end
  end
end
