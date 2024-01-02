# frozen_string_literal: true

# Deliverable
class Deliverable < ApplicationRecord
  validates :name, presence: true
  validates :deadline, presence: true

  belongs_to :project
end
