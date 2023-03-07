# frozen_string_literal: true

module ViewComponentScopedCss
  #
  # A class for providing styles to a view component.
  # If you include this class, you will be able to describe scss in the namespace of each component
  #
  module Base
    extend ActiveSupport::Concern

    class_methods do
      def component_css_tag
        ViewComponentScopedCss::CurrentContext.render_if_need(self)
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

    def component_tag(name = ViewComponentScopedCss.config.component_tag, **tag_options, &block)
      safe_join(
        [
          self.class.component_css_tag,
          content_tag(
            name,
            class: [self.class.component_identifier_for_css, tag_options[:class]].compact.join(" "),
            **component_options, &block
          )
        ].compact
      )
    end
  end
end
