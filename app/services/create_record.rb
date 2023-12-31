# frozen_string_literal: true

# CreateRecordService
class CreateRecord
  def initialize(model, params)
    @model = model
    @params = params
  end

  def call
    @record = @model.new(@params)
    @record.save
    @record
  end
end
