# frozen_string_literal: true

module EchoCraft
  module ServiceObjects
    # Basic Response to Destroy a Record on ServiceObject
    class Destroy < EchoCraft::ServiceObject
      def initialize(record)
        super()
        @record = record
      end

      def destroyed
        @status = ::Rack::Utils.status_code(:ok)
        set_service_successful
      end

      def unprocessabled
        @status = ::Rack::Utils.status_code(:unprocessable_entity)
      end
    end
  end
end
