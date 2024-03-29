# frozen_string_literal: true

require 'rails/generators/resource_helpers'
require 'model_ancestry/base'

module Rails
  module Generators
    # WortScaffoldControllerGenerator
    # Clone ScaffoldControllerGenerator
    # dependecies:
    #   - ModelAncestry
    #   - RouteTour
    class WortScaffoldControllerGenerator < NamedBase # :nodoc:
      include ResourceHelpers
      source_root File.expand_path('templates', __dir__)

      check_class_collision suffix: 'Controller'

      class_option :helper, type: :boolean
      class_option :orm, banner: 'NAME', type: :string, default: 'active_record',
                         desc: 'ORM to generate the controller for'
      class_option :parent_attribute, type: :string
      # TODO: add option or logic to know the logic about modules

      # class_option :api, type: :boolean,
      #                    desc: 'Generate API controller'

      class_option :skip_routes, type: :boolean, desc: "Don't add routes to config/routes.rb."
      class_option :skip_services, type: :boolean, desc: "Don't add services."
      class_option :skip_locales, type: :boolean, desc: "Don't add locales to config/locales."

      argument :attributes, type: :array, default: [], banner: 'field:type field:type'

      def init
        set_parent_attribute if options.parent_attribute
        create_controller_files
      end

      hook_for :template_engine, as: :scaffold do |template_engine|
        invoke template_engine unless options.api?
      end

      # generate routes
      invoke :route_tour do |route|
        invoke route unless options.skip_routes?
      end
      # hook_for :resource_route, required: true do |route|
      #   invoke route unless options.skip_routes?
      # end

      hook_for :test_framework, as: :scaffold

      # Invoke the helper using the controller name(pluralized)
      hook_for :helper, as: :scaffold do |invoked|
        invoke invoked, [controller_name]
      end

      # generate services
      invoke :servi_craft do |services|
        invoke services unless options.skip_services?
      end

      # generate locales
      invoke :sobremesa do |locales|
        invoke locales unless options.skip_locales?
      end

      private

      def set_parent_attribute
        @parent_attribute = ::ModelAncestry::Base.find_parent(attributes, options.parent_attribute)
      end

      def create_controller_files
        # template_file = options.api? ? 'api_controller.rb' : 'controller.rb'
        template_file = 'controller.rb.tt'
        template template_file,
                 File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
      end

      def permitted_params
        attachments, others = attributes_names.partition { |name| attachments?(name) }
        params = others.map { |name| ":#{name}" }
        params += attachments.map { |name| "#{name}: []" }
        params.join(', ')
      end

      def attachments?(name)
        attribute = attributes.find { |attr| attr.name == name }
        attribute&.attachments?
      end
    end
  end
end
