# frozen_string_literal: true

require 'servi_craft/query'
module Projects
  # Service object to query projects.
  # [Modified by] rails generate servi_craft project
  # [Last modified] 2024-02-07
  class Query < ServiCraft::Query
    def initialize(base = ::Project.all, page: 1, rows: nil)
      super(base, page:, rows:)
    end
  end
end
