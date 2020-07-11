require 'active_model_serializers'
require "filterable_attributes/version"

module ActiveModelSerializers
  module FilterableAttributes
    class ::ActiveModel::Serializer::Attribute
      def value(serializer)
        if filtered = serializer.class._filtered_attributes[name]
          if filtered.excluded?(serializer)
            super
          else
            filtered.value(serializer)
          end
        else
          super
        end
      end
    end

    class FilteredAttribute < ActiveModel::Serializer::Attribute
      def value(serializer)
        if block
          serializer.instance_eval(&block)
        else
          serializer.read_attribute_for_serialization(name)
        end
      end

      def evaluate_condition(serializer)
        case condition
        when Symbol
          serializer.send(condition)
        when String
          serializer.instance_eval(condition)
        when Proc
          if condition.arity.zero?
            serializer.instance_exec(&condition)
          else
            serializer.instance_exec(serializer, &condition)
          end
        end
      end
    end

    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def _filtered_attributes
        @_filtered_attributes ||= {}
      end

      def filter_attribute(name, options = {}, &block)
        _filtered_attributes[name] = FilteredAttribute.new(name, options, block)
      end

      def filter_attributes(*args, &block)
        options = args.extract_options!
        args.each do |name|
          filter_attribute(name, options, &block)
        end
      end
    end
  end
end
