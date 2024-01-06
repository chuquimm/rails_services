# frozen_string_literal: true

module EchoCraft
  # Basic Response to Service Objects
  class ServiceObject < EchoCraft::Response
    attr_accessor :record, :successful

    def initialize
      super
      @record = nil
      @successful = false
      @status = change_status(:accepted)
    end

    def set_service_successful
      @successful = true
    end

    def unprocessabled
      change_status(:unprocessable_entity)
    end
  end
end
