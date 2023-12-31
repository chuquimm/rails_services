# frozen_string_literal: true

module Projects
  # ::Projects::Destroy
  class Destroy
    def initialize(project)
      @project = project
    end

    def call
      @project.destroy
    rescue ActiveRecord::InvalidForeignKey
      false
    end
  end
end
