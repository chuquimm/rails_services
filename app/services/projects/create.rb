# frozen_string_literal: true

module Projects
  # ::Projects::Create
  # [Modified by] rails generate init_services project
  # [Last modified] 2024-01-04
  class Create < CreateRecord
    # Set params to create a new project.
    # [Modified by] rails generate init_services project
    # [Last modified] 2024-01-04
    def initialize(params)
      super(::Project, params)
    end

    private

    # Processes to do after save the project.
    # [Modified by] chuquimm
    # [Last modified] 2024-01-04
    def after_save_process
      create_scope_deliverable
      super()
    end

    # Create intance of ::Deliverable to decribe the project's scope.
    # [Modified by] chuquimm
    # [Last modified] 2024-01-04
    def create_scope_deliverable
      params = { name: 'Scope', deadline: Date.today + 2.week, project_id: @record.id }
      ::Deliverables::Create.new(params).call
    end
  end
end
