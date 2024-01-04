# frozen_string_literal: true

module Responses
  module ServiceObjects
    # Basic Response to Update a Record on ServiceObject
    class Update < Responses::ServiceObject
      attr_accessor :params

      def initialize(record, params)
        super()
        @record = record
        @params = params
        @status = StatusCodes::Success.accepted
      end

      def updated
        @status = StatusCodes::Success.ok
        set_service_successful
      end

      def unprocessabled
        @status = StatusCodes::ClientError.unprocessable_entity
      end
    end
  end
end
