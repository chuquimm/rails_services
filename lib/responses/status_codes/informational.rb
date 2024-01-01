# frozen_string_literal: true

module Responses
  module StatusCodes
    # Informational HTTP StatusCode
    class Informational
      def self.continue
        100
      end

      def self.switching_protocols
        101
      end

      def self.processing
        102
      end
    end
  end
end
