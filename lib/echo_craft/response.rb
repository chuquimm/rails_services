# frozen_string_literal: true

module EchoCraft
  # Basic Response with EchoCraft Struct
  class Response
    attr_reader :status, :message

    def initialize
      change_status(:processing)
    end

    def status=(status)
      change_status(status)
    end

    def change_status(status)
      @status = ::Rack::Utils.status_code(status)
      @message = ::Rack::Utils::HTTP_STATUS_CODES[@status]
      @status
    end
  end
end
