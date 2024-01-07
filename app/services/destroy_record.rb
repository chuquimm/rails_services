# frozen_string_literal: true

# Destroy Record Service
class DestroyRecord
  def initialize(record)
    @record = record
    @response = ::EchoCraft::ServiceObjects::Destroy.new(@record)
  end

  def call(before_destroy: proc {},
           after_successful_destroy: proc {},
           after_failed_destroy: proc {},
           after_destroy: proc {})

    before_destroy.call
    process_record_destroy(after_successful_destroy:, after_failed_destroy:)
    after_destroy.call

    @response
  end

  private

  def process_record_destroy(after_successful_destroy: proc {},
                             after_failed_destroy: proc {})

    @record.destroy
    after_successful_destroy.call

    @response.destroyed
  rescue ActiveRecord::InvalidForeignKey => e
    @record.errors.add(:base, :fk_constraint, message: e.cause.message)
    unprocessabled_destroy(after_failed_destroy:)
  rescue StandardError
    unprocessabled_destroy(after_failed_destroy:)
  end

  def unprocessabled_destroy(after_failed_destroy: proc {})
    after_failed_destroy.call
    @response.unprocessabled
  end
end
