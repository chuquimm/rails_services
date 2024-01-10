# frozen_string_literal: true

# Route
class RouteGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def gen_init
    return if options[:actions].present?

    @route_class_name = "#{[regular_class_path, file_name.pluralize.camelcase].flatten.map(&:camelcase)
      .join('::')}Routes"

    create_route_file

    # mods = Array(regular_class_path)
    extended_route = @route_class_name
    # return if behavior == :revoke && extended_route != @route_class_name

    insert_extend_route('config/routes.rb', extended_route)
  end

  private

  def create_route_file
    template 'route.template', route_path
    return if behavior == :revoke

    route "resources :#{file_name.pluralize}", namespace: regular_class_path
  end

  def route_path
    dir = ['config', 'routes', regular_class_path].join('/')
    "#{dir}/#{file_name.pluralize.underscore}_routes.rb"
  end

  # Original: https://github.com/rails/rails/blob/ef04fbb3b256beececfa44c47c4ec93ac6945e59/railties/lib/rails/generators/rails/resource_route/resource_route_generator.rb
  # Modified: use a method (route_path) instead of 'config/routes.rb'
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

      inject_into_file route_path, routing_code, after: "router.instance_exec do\n", verbose: false, force: false
    end
  end

  def insert_extend_route(file_path, class_name, indentation: 2, after: "routes.draw do\n")
    inject_into_file(file_path, after:) do
      rebase_indentation("extend #{class_name}\n", indentation)
    end
  end
end
