# frozen_string_literal: true

module EchoCraft
  module ServiceObjects
    # Basic Response to Create a Record on ServiceObject
    class Create < EchoCraft::ServiceObject
      attr_accessor :params

      def initialize(params)
        super()
        @record = nil
        @params = params
      end

      def created(record)
        @record = record
        @status = ::Rack::Utils.status_code(:created)
        set_service_successful
      end

      def unprocessabled(record)
        @record = record
        @status = ::Rack::Utils.status_code(:unprocessable_entity)
      end
    end
  end
end
