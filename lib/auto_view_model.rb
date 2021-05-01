# frozen_string_literal: true

require "action_view"
require "active_support"

require_relative "auto_view_model/version"
require_relative "auto_view_model/base"

module AutoViewModel
  class Error < StandardError; end
end
