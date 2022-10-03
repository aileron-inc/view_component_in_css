# frozen_string_literal: true

module ViewComponentScopedCss
  #
  # Hook before_render to view component to provide inline css
  #
  module Hook
    extend ActiveSupport::Concern
    included do
      include ActiveSupport::Callbacks
      define_callbacks :render
    end

    if ViewComponentScopedCss.config.compile_cache
      def before_render
        run_callbacks :render do
          ViewComponentScopedCss::CurrentContext.add(self)
        end
      end
    else
      def before_render
        run_callbacks :render do
          self.class.reload_component_css_tag
          ViewComponentScopedCss::CurrentContext.add(self)
        end
      end
    end

    class_methods do
      def before_render(&block)
        set_callback(:render, :before, &block)
      end
    end
  end
end
