# frozen_string_literal: true

module ViewComponentScopedCss
  #
  # A class for providing styles to a view component.
  # If you include this class, you will be able to describe scss in the namespace of each component
  #
  module Base
    extend ActiveSupport::Concern

    included do
      include ViewComponentScopedCss::Hook
    end

    class_methods do
      def component_css_tag
        ViewComponentScopedCss::CurrentContext.add(self)
      end

      def component_identifier
        @component_identifier ||= name.sub("::Component", "").underscore.split("/").join("::")
      end

      def component_identifier_for_css
        @component_identifier_for_css ||= ["viewcomponent", component_identifier, "component"].compact.join("::")
      end
    end

    def component_options
      {}
    end

    def component_tag_class
      self.class.component_identifier_for_css
    end

    def component_tag(name = ViewComponentScopedCss.config.component_tag, &block)
      content_tag(
        name,
        class: [self.class.component_identifier_for_css, component_options[:class]].compact.join(" "),
        **component_options,
        &block
      )
    end
  end
end
