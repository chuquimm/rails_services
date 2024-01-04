# frozen_string_literal: true

module Deliverables
  # ::Deliverables::Create
  # [Modified by] rails generate init_services deliverable
  # [Last modified] 2024-01-04
  class Create < CreateRecord
    # Set params to create a new deliverable.
    # [Modified by] rails generate init_services deliverable
    # [Last modified] 2024-01-04
    def initialize(params)
      super(::Deliverable, params)
    end
  end
end
