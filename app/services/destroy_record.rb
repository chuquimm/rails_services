# frozen_string_literal: true

# Destroy Record Service
class DestroyRecord
  def initialize(record)
    @record = record
    @response = ::Responses::ServiceObjects::Destroy.new(@record)
  end

  def call
    before_process
    @record.destroy
    after_process
    @response.destroyed
    @response
  rescue ActiveRecord::InvalidForeignKey
    @response.unprocessabled
    @response
  end

  private

  def after_process; end

  def before_process; end
end
