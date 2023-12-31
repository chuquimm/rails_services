# frozen_string_literal: true

module Projects
  # Projects::Update service
  class Update
    def initialize(project, params)
      @project = project
      @params = params
    end

    def call
      @project.assign_attributes(@params)
      @project.save ? true : false
    end
  end
end
