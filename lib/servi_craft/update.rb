# frozen_string_literal: true

module ServiCraft
  # UpdateRecordService
  class Update
    attr_reader :model, :record, :params, :response

    def initialize(record, params)
      @record = record
      @model = @record.class
      @params = params
      @response = ::EchoCraft::ServiceObjects::Update.new(@record, @params)
    end

    def call(before_assign_attributes: proc {},
             before_update: proc {},
             after_successful_update: proc {},
             after_failed_update: proc {},
             after_update: proc {})
      begin
        before_assign_attributes.call
        @record.assign_attributes(@params)
        before_update.call
        process_record_update @record.save, after_successful_update:, after_failed_update:
      rescue StandardError
        @response.unprocessabled
      end
      after_update.call
      @response
    end

    private

    def process_record_update(result, after_successful_update: proc {},
                              after_failed_update: proc {})
      if result
        after_successful_update.call
        @response.updated
      else
        after_failed_update.call
        @response.unprocessabled
      end
      result
    end
  end
end
