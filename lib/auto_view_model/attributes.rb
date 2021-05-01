# frozen_string_literal: true

module AutoViewModel
  module Attributes
    extend ActiveSupport::Concern

    included do
      class_attribute :_optional_attributes, default: {}
      class_attribute :_required_attributes, default: Set.new
    end

    class_methods do
      def requires(parameter)
        _required_attributes << parameter

        attr_reader parameter
      end

      def accepts(parameter, default: nil)
        _optional_attributes[parameter] = default

        attr_reader parameter
      end

      def inherited(subclass)
        subclass._optional_attributes = _optional_attributes.dup
        subclass._required_attributes = _required_attributes.dup
        super
      end
    end

    def initialize(locals)
      _construct_attributes(locals)
    end

    private

    def _construct_attributes(args)
      _required_attributes.each do |attr|
        if !args.has_key?(attr)
          raise ArgumentError.new("Missing view keyword argument :#{attr}") # Simulate required kwargs
        end

        instance_variable_set("@#{attr}", args[attr])
      end

      _optional_attributes.each do |attr, default|
        if args.has_key?(attr)
          value = args[attr]
          instance_variable_set("@#{attr}", value)
        else
          value = args[attr]
          instance_variable_set("@#{attr}", default)
        end
      end
    end
  end
end
