# frozen_string_literal: true

module Projects
  # Projects::Create service
  class Create < CreateRecord
    def call
      @project = ::Project.new(@params)
      @project.save
      @project
    end
  end
end
