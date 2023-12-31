# frozen_string_literal: true

module Projects
  # Projects::Create service
  class Create
    def initialize(params)
      @params = params
    end

    def call
      @project = ::Project.new(@params)
      @project.save
      @project
    end
  end
end
