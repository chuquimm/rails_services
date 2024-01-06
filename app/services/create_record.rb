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
    @record = @model.new(@params)
    process @record.save
    @response
  end

  private

  def process(result)
    if result
      @response.created(@record)
    else
      @response.unprocessabled(@record)
    end
  end
end
