# frozen_string_literal: true

module Responses
  # Basic Response to Service Objects
  class ServiceObject
    attr_accessor :record, :status, :message, :successful

    StatusCodes = ::Responses::StatusCodes

    def initialize(message: '')
      @record = nil
      @status = StatusCodes::Informational.processing
      @message = message
      @successful = false
    end

    def set_service_successful
      @successful = true
    end
  end
end
