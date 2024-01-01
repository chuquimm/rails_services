# frozen_string_literal: true

module Responses
  module StatusCodes
    # ClientError HTTP StatusCode
    class ClientError
      def self.unprocessable_entity
        422
      end
    end
  end
end
