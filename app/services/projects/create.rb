# frozen_string_literal: true

module Projects
  # Projects::Create service
  class Create < CreateRecord
    def initialize(params)
      super(::Project, params)
    end

    private

    def after_save_process
      ::Deliverable.create(name: 'Scope', deadline: Date.today + 1.week)
    end
  end
end
