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
    @record.assign_attributes(@params)
    process @record.save
    @response
  end

  private

  def process(result)
    if result
      @response.updated
    else
      @response.unprocessabled
    end
    result
  end
end
