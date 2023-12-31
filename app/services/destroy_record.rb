# frozen_string_literal: true

# Destroy Record Service
class DestroyRecord
  def initialize(record)
    @record = record
  end

  def call
    @record.destroy
  rescue ActiveRecord::InvalidForeignKey
    false
  end
end
