# frozen_string_literal: true

# Route
class RouteTourGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def gen_init
    return if options[:actions].present?

    create_module_files unless behavior == :revoke
    create_route_file
  end

  private

  def root_routes
    'config/routes.rb'
  end

  def create_route_file
    @route_class_name = route_class_name(file_name.pluralize.camelcase)
    template 'route.template', class_route_path
    insert_route_file
    return if behavior == :revoke

    route "resources :#{file_name.pluralize}", namespace: regular_class_path
  end

  def insert_route_file
    if Array(regular_class_path).any?
      insert_extend_route(route_path(nil), @route_class_name, after: "router.instance_exec do\n", indentation: 6)
    else
      insert_extend_route(root_routes, @route_class_name)
    end
  end

  def class_route_path
    route_path(file_name.pluralize.underscore)
  end

  # Original: https://github.com/rails/rails/blob/ef04fbb3b256beececfa44c47c4ec93ac6945e59/railties/lib/rails/generators/rails/resource_route/resource_route_generator.rb
  # Modified: use a method (class_route_path) instead of 'config/routes.rb'
  # Make an entry in Rails routing file <tt>config/routes.rb</tt>
  #
  #   route "root 'welcome#index'"
  #   route "root 'admin#index'", namespace: :admin
  def route(routing_code, namespace: nil)
    namespace = Array(namespace)
    routing_code = namespace.reverse.reduce(routing_code) do |code, name|
      "namespace :#{name} do\n#{rebase_indentation(code, 2)}end"
    end

    log :route, routing_code

    in_root do
      routing_code = rebase_indentation(routing_code, 6)

      inject_into_file class_route_path, routing_code, after: "router.instance_exec do\n", verbose: false, force: false
    end
  end

  def insert_extend_route(file_path, class_name, indentation: 2, after: "routes.draw do\n")
    return unless File.exist?(file_path)

    inject_into_file(file_path, after:) do
      rebase_indentation("extend #{class_name}\n", indentation)
    end
  end

  def create_module_files
    selected_modules = []
    Array(regular_class_path).each do |mod|
      selected_modules << mod
      create_module_route(selected_modules)
    end
  end

  def create_module_route(selected_modules)
    @route_class_name = route_class_name(nil, mods: selected_modules)
    path = route_path(nil, mods: selected_modules)
    return if File.exist? path

    template 'route.template', path
    prev_mods = selected_modules[..-2]
    prev_path = prev_mods.any? ? route_path(nil, mods: prev_mods) : root_routes
    after_line = prev_mods.any? ? "router.instance_exec do\n" : "routes.draw do\n"
    indentation = prev_mods.any? ? 6 : 2
    insert_extend_route(prev_path, @route_class_name, after: after_line, indentation:)
  end

  def route_class_name(class_name, mods: regular_class_path)
    names = [mods, class_name].flatten.compact
    "#{names.map(&:camelcase).join('::')}Routes"
  end

  def route_path(class_name, mods: regular_class_path)
    dirs = %w[config routes]
    names = [mods, class_name].flatten.compact
    "#{[dirs, names].flatten.join('/')}_routes.rb"
  end
end
