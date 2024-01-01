# frozen_string_literal: true

# UpdateRecordService
class UpdateRecord
  attr_accessor :model, :record, :params, :response

  def initialize(record, params)
    @record = record
    @model = @record.class
    @params = params
    @response = ::Responses::ServiceObjects::Update.new(@record, @params)
  end

  def call
    @record.assign_attributes(@params)
    process @record.save
    @response
  end

  private

  def before_save_process; end

  def process(result)
    if result
      after_save_process
      @response.updated
    else
      @response.unprocessabled
    end
    result
  end

  def after_save_process; end
end
