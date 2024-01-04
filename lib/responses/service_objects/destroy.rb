# frozen_string_literal: true

module Responses
  module ServiceObjects
    # Basic Response to Destroy a Record on ServiceObject
    class Destroy < Responses::ServiceObject
      def initialize(record)
        super()
        @record = record
        @status = StatusCodes::Success.accepted
      end

      def destroyed
        @status = StatusCodes::Success.ok
        set_service_successful
      end

      def unprocessabled
        @status = StatusCodes::ClientError.unprocessable_entity
      end
    end
  end
end
