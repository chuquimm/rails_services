# frozen_string_literal: true

module Responses
  module ServiceObjects
    # Basic Response to Create a Record on ServiceObject
    class Create < Responses::ServiceObject
      attr_accessor :params

      def initialize(params)
        super()
        @record = nil
        @params = params
        @status = StatusCodes::Success.accepted
      end

      def created(record)
        @record = record
        @status = StatusCodes::Success.created
        set_service_successful
      end

      def unprocessabled(record)
        @record = record
        @status = StatusCodes::ClientError.unprocessable_entity
      end
    end
  end
end
