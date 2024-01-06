# frozen_string_literal: true

module EchoCraft
  module ServiceObjects
    # Basic Response to Update a Record on ServiceObject
    class Update < EchoCraft::ServiceObject
      attr_accessor :params

      def initialize(record, params)
        super()
        @record = record
        @params = params
      end

      def updated
        @status = ::Rack::Utils.status_code(:ok)
        set_service_successful
      end

      def unprocessabled
        @status = ::Rack::Utils.status_code(:unprocessable_entity)
      end
    end
  end
end
