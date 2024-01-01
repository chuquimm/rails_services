# frozen_string_literal: true

module Responses
  module ServiceObjects
    # Basic Response to Create Record on ServiceObject
    class Update < Responses::ServiceObject
      attr_accessor :params, :errors

      def initialize(record, params)
        super()
        @record = record
        @params = params
        @status = StatusCodes::Success.accepted
        @errors = ActiveModel::Errors.new(@record)
      end

      def updated
        @status = StatusCodes::Success.ok
        complete_service
      end

      def unprocessabled
        @status = StatusCodes::ClientError.unprocessable_entity
        @errors = @record.errors
      end
    end
  end
end
