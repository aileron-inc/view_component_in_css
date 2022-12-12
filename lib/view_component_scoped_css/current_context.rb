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

    def self.add(view_component_class)
      self.css ||= {}
      self.css[view_component_class.name] ||= ViewComponentScopedCss::Tag.new(view_component_class).call
      self.css[view_component_class.name]
    end

    resets { self.css = {} } if ViewComponentScopedCss.config.compile_cache
  end
end
