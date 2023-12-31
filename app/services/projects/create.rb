# frozen_string_literal: true

module Projects
  # Projects::Create service
  class Create < CreateRecord
    def initialize(params)
      super(::Project, params)
    end
  end
end
