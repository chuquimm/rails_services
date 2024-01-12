# frozen_string_literal: true

require 'rails/generators/rails/resource/resource_generator'

module Rails
  module Generators
    # WortflowGenerator
    # Generate scaffold with services, structured routes and locales.
    # Required:
    # - Add in application.rb the next configuration to avoid duplicate routes.
    #   config.generators do |generate|
    #     generate.resource_route false
    #   end
    # Dependecies
    # - ServiCraft
    # - EchoCraft
    # - RouteTour
    # - Sobremesa
    class WortflowGenerator < ResourceGenerator
      remove_hook_for :resource_controller
      remove_class_option :actions

      class_option :api, type: :boolean,
                         desc: 'Generate API-only controller and tests, with no view templates'
      class_option :resource_route, type: :boolean, default: false

      hook_for :scaffold_controller, required: true

      invoke :servi_craft # generate services
      invoke :route_tour # generate routes
      invoke :sobremesa # generate locales
    end
  end
end
