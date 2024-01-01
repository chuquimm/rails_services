# frozen_string_literal: true

module Responses
  module StatusCodes
    # Success HTTP StatusCode
    class Success
      def self.ok
        200
      end

      def self.created
        201
      end

      def self.accepted
        202
      end
    end
  end
end
