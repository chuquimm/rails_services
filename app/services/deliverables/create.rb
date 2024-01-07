# frozen_string_literal: true

module Deliverables
  # Service object to create a new deliverable.
  # [Modified by] rails generate init_services deliverable
  # [Last modified] 2024-01-07
  class Create < ServiCraft::Create
    # Set params to create a new deliverable.
    # [Modified by] rails generate init_services deliverable
    # [Last modified] 2024-01-07
    def initialize(params)
      super(::Deliverable, params)
    end
  end
end
