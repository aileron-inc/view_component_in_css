# frozen_string_literal: true

module ViewComponentScopedCss
  #
  # Manage whether CSS has been Render
  #
  class CurrentContext < ActiveSupport::CurrentAttributes
    attribute :called

    def self.render_if_need(view_component_class)
      self.called ||= {}
      if called[view_component_class.name]
        nil
      else
        called[view_component_class.name] = true
        ViewComponentScopedCss::Tag.new(view_component_class).call
      end
    end

    resets { self.called = {} }
  end
end
