# frozen_string_literal: true

module ViewComponentScopedCss
  #
  # ViewComponentScopedCss config
  #
  class Config
    include ActiveSupport::Configurable
    config_accessor(:component_tag) { :div }
    config_accessor(:compile_cache) { true }
  end
end
