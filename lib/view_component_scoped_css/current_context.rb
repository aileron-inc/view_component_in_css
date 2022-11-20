# frozen_string_literal: true

module ViewComponentScopedCss
  #
  # Class for holding the <style></style> of the component called on each request.
  #
  class CurrentContext < ActiveSupport::CurrentAttributes
    attribute :css

    def self.render
      return if css.empty?

      css.values.join("\n").html_safe
    end

    def self.add(view_component)
      self.css ||= {}
      self.css[view_component.class.name] ||= view_component.class.component_css_tag
    end

    resets { self.css = {} }
  end
end
