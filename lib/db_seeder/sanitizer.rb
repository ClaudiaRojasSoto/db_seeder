# frozen_string_literal: true

require "securerandom"

module DbSeeder
  class Sanitizer
    def initialize(config)
      @rules = config.sanitize_rules || {}
    end

    # model: ActiveRecord model class
    # attributes: hash (string/symbol keys)
    def sanitize(model, attributes)
      model_key = model_config_key(model)
      model_rules = @rules[model_key] || {}

      attributes.each_with_object({}) do |(key, value), result|
        rule = model_rules[key.to_sym]
        result[key] = apply_rule(rule, value)
      end
    end

    private

    def model_config_key(model)
      if model.respond_to?(:table_name) && model.table_name
        model.table_name.to_sym
      elsif model.respond_to?(:name) && model.name && !model.name.empty?
        model.name.underscore.to_sym
      else
        model.to_s.underscore.to_sym
      end
    end

    def apply_rule(rule, value)
      return value if rule.nil?

      if rule.respond_to?(:call)
        return rule.call(value) if rule.arity <= 1
        return rule.call(value, rule_context(value))
      end

      case rule
      when :null
        nil
      when :random_email
        "user_#{SecureRandom.hex(4)}@example.com"
      else
        value
      end
    end

    # reserved for future expansion without changing the public API
    def rule_context(_value)
      {}
    end
  end
end


