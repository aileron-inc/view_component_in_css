# frozen_string_literal: true

require_relative "view_component_in_css/version"
require "active_support"
require "sass-embedded"

#
# Provide a style for each view component that can be handled as css in js.
#
module ViewComponentInCss
  class Error < StandardError; end
  # Your code goes here...

  extend ActiveSupport::Autoload
  autoload :Loader
  autoload :Tag
  autoload :Context
end
