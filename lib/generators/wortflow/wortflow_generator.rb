# frozen_string_literal: true

require 'rails/generators/rails/resource/resource_generator'

module Rails
  module Generators
    class WortflowGenerator < ResourceGenerator # :nodoc:
      remove_hook_for :resource_controller
      remove_class_option :actions

      class_option :api, type: :boolean,
                         desc: 'Generate API-only controller and tests, with no view templates'
      class_option :resource_route, type: :boolean
      class_option :services, type: :array, default: %w[create update destroy]

      hook_for :scaffold_controller, required: true

      invoke :init_services
      invoke :route
      invoke :translator
    end
  end
end
