# frozen_string_literal: true

module Responses
  # Basic Response to Service Objects
  class ServiceObject
    attr_accessor :record, :status, :message, :completed

    StatusCodes = ::Responses::StatusCodes

    def initialize(message: '')
      @record = nil
      @status = StatusCodes::Informational.processing
      @message = message
      @completed = false
    end

    def complete_service
      @completed = true
    end
  end
end
