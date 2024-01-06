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
        change_status(:ok)
        set_service_successful
      end
    end
  end
end
