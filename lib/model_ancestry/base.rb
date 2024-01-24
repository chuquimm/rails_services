# frozen_string_literal: true

module ModelAncestry
  # ModelAncestry
  module Base
    def self.find_parent(attributes, name)
      return unless name

      attrs = attributes.filter { |attr| attr.type == :references }
      attrs.find { |attr| attr.name.downcase == name.downcase }
    end
  end
end
