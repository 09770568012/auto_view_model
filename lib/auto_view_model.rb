# frozen_string_literal: true

require "action_view"
require "active_support"

require_relative "auto_view_model/version"
require_relative "auto_view_model/attributes"

module AutoViewModel
  class Error < StandardError; end

  class Base
    include AutoViewModel::Attributes

    def initialize(local_assigns, view_context:)
      super(local_assigns)
      @view_context = view_context
    end

    # View models should support helper methods available in
    # the template. By delegating missing methods to view
    # context, we can support all existing Rails and
    # application defined helpers.
    def method_missing(method, *args, &block)
      if @view_context.respond_to?(method)
        @view_context.public_send(method, *args, &block)
      else
        super
      end
    end
    ruby2_keywords :method_missing if respond_to?(:ruby2_keywords, true)

    def respond_to_missing?(method, include_all)
      @view_context.respond_to?(method, include_all)
    end
  end

  module TemplatePatch
    def locals_code
      class_name = virtual_path.classify
      Object.const_get(class_name)

      "view=#{class_name}.new(local_assigns, view_context: self);"
    rescue NameError
      super
    end
  end
end
