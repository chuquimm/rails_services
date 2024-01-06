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
    before_save_process
    process @record.save
    @response
  end

  private

  def before_save_process; end

  def process(result)
    if result
      after_save_process
      @response.created(@record)
    else
      @response.unprocessabled(@record)
    end
  end

  def after_save_process; end
end
