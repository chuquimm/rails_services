# frozen_string_literal: true

module EchoCraft
  # Basic Response with EchoCraft Struct
  class Response
    attr_accessor :status, :message

    def initialize(message: '')
      @status = ::Rack::Utils.status_code(:processing)
      @message = message
    end
  end
end
