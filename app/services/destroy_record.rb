# frozen_string_literal: true

# Destroy Record Service
class DestroyRecord
  def initialize(record)
    @record = record
    @response = ::EchoCraft::ServiceObjects::Destroy.new(@record)
  end

  def call
    @record.destroy
    @response.destroyed
    @response
  rescue ActiveRecord::InvalidForeignKey => e
    @record.errors.add(:base, :fk_constraint, message: e.cause.message)
    @response.unprocessabled
    @response
  end
end
