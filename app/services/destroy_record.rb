# frozen_string_literal: true

# Destroy Record Service
class DestroyRecord
  def initialize(record)
    @record = record
    @response = ::EchoCraft::ServiceObjects::Destroy.new(@record)
  end

  def call
    begin
      @record.destroy
      @response.destroyed
    rescue ActiveRecord::InvalidForeignKey => e
      @record.errors.add(:base, :fk_constraint, message: e.cause.message)
      @response.unprocessabled
    rescue StandardError
      @response.unprocessabled
    end
    @response
  end
end
