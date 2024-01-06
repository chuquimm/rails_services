# frozen_string_literal: true

module EchoCraft
  # Basic Response to Service Objects
  class ServiceObject < EchoCraft::Response
    attr_accessor :record, :successful

    def initialize(message: '')
      super(message:)
      @record = nil
      @successful = false
      @status = ::Rack::Utils.status_code(:accepted)
    end

    def set_service_successful
      @successful = true
    end
  end
end
