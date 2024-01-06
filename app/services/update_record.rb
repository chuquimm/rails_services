# frozen_string_literal: true

# UpdateRecordService
class UpdateRecord
  attr_reader :model, :record, :params, :response

  def initialize(record, params)
    @record = record
    @model = @record.class
    @params = params
    @response = ::EchoCraft::ServiceObjects::Update.new(@record, @params)
  end

  def call
    begin
      @record.assign_attributes(@params)
      process_record_update @record.save
    rescue StandardError
      @response.unprocessabled
    end
    @response
  end

  private

  def process_record_update(result)
    if result
      @response.updated
    else
      @response.unprocessabled
    end
    result
  end
end
