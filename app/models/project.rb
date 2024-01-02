# frozen_string_literal: true

# ::Project
class Project < ApplicationRecord
  validates :name, presence: true

  has_many :deliverables
end
