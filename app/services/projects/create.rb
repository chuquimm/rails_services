# frozen_string_literal: true

require 'servi_craft/create'
module Projects
  # Service object to create a new project.
  # [Modified by] rails generate servi_craft project
  # [Last modified] 2024-02-01
  class Create < ServiCraft::Create
    # Set params to create a new project.
    # [Modified by] rails generate servi_craft project
    # [Last modified] 2024-02-01
    def initialize(params)
      super(::Project, params)
    end
  end
end
