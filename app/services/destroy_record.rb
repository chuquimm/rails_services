# frozen_string_literal: true

# Destroy Record Service
class DestroyRecord
  def initialize(record)
    @record = record
    @response = ::EchoCraft::ServiceObjects::Destroy.new(@record)
  end

  def call
    before_save_process
    @record.destroy
    after_save_process
    @response.destroyed
    @response
  rescue ActiveRecord::InvalidForeignKey => e
    @record.errors.add(:base, :fk_constraint, message: e.cause.message)
    @response.unprocessabled
    @response
  end

  private

  def after_save_process; end

  def before_save_process; end
end
