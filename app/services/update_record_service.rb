# frozen_string_literal: true

# UpdateRecordService
class UpdateRecordService
  def initialize(record, params)
    @record = record
    @params = params
  end

  def call
    @record.assign_attributes(@params)
    @record.save ? true : false
  end
end
