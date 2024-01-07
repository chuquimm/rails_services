# frozen_string_literal: true

# CreateRecordService
class CreateRecord
  attr_reader :model, :record, :params, :response

  def initialize(model, params)
    @model = model
    @params = params
    @response = ::EchoCraft::ServiceObjects::Create.new(@params)
  end

  def call(before_assign_attributes: proc {},
           before_create: proc {},
           after_create: proc {},
           after_successfull_create: proc {},
           after_failed_create: proc {})
    begin
      before_assign_attributes.call
      @record = @model.new(@params)
      before_create.call
      process_record_create @record.save, after_successfull_create:, after_failed_create:
    rescue StandardError
      @response.unprocessabled
    end
    after_create.call
    @response
  end

  private

  def process_record_create(result, after_successfull_create: proc {}, after_failed_create: proc {})
    if result
      after_successfull_create.call
      @response.created(@record)
    else
      after_failed_create.call
      @response.unprocessabled(@record)
    end
  end
end
