# frozen_string_literal: true

require_relative "attributes"

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
end
