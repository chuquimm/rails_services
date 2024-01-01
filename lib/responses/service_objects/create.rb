# frozen_string_literal: true

module Responses
  module ServiceObjects
    # Basic Response to Create Record on ServiceObject
    class Create < Responses::ServiceObject
      attr_accessor :params, :errors

      def initialize(params)
        super()
        @record = nil
        @params = params
        @status = StatusCodes::Success.accepted
        @errors = ActiveModel::Errors.new(@record)
      end

      def created(record)
        @record = record
        @status = StatusCodes::Success.created
        complete_service
      end

      def unprocessabled(record)
        @record = record
        @errors = record.errors
        @status = StatusCodes::ClientError.unprocessable_entity
      end
    end
  end
end
