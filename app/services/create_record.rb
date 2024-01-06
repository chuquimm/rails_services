# frozen_string_literal: true

# CreateRecordService
class CreateRecord
  attr_reader :model, :record, :params, :response

  def initialize(model, params)
    @model = model
    @params = params
    @response = ::EchoCraft::ServiceObjects::Create.new(@params)
  end

  def call
    begin
      @record = @model.new(@params)
      process_record_create @record.save
    rescue StandardError
      @response.unprocessabled
    end
    @response
  end

  private

  def process_record_create(result)
    if result
      @response.created(@record)
    else
      @response.unprocessabled(@record)
    end
  end
end
