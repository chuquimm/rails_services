# frozen_string_literal: true

# ProjectsRoutes
module ProjectsRoutes
  def self.extended(router)
    router.instance_exec do
      resources :projects
    end
  end
end
