# frozen_string_literal: true

module ViewComponentInCss
  #
  # Hook before_render to view component to provide inline css
  #
  module Context
    extend ActiveSupport::Concern
    included do
      include ActiveSupport::Callbacks
      define_callbacks :render
    end

    def before_render
      run_callbacks :render do
        ViewComponentInCss::CurrentContext.add(self)
      end
    end

    class_methods do
      def before_render
        set_callback(:render, :before, &block)
      end
    end
  end
end
