# frozen_string_literal: true

module ViewComponentInCss
  #
  # Class for holding the <style></style> of the component called on each request.
  #
  class CurrentContext < ActiveSupport::CurrentAttributes
    attribute :css

    def self.add(view_component)
      self.css ||= {}
      self.css[view_component.class.name] ||= ViewComponentInCss::Tag.new(view_component).call
    end

    resets { self.css = {} }
  end
end
