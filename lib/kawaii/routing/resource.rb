class Kawaii::Routing::Resource
  METHODS = [:index, :new, :create, :edit, :update, :destroy]

  def initialize(routes, name, methods, namespace = nil, parent = nil, &block)
    @routes            = routes
    @name              = name
    @parent            = parent
    @methods           = methods || METHODS
    @namespace         = namespace
    @actions_generator = Kawaii::Routing::Services::GenerateResourceActions
    generate_actions
    instance_eval(&block) if block_given?
  end
  attr_reader :routes, :name, :parent, :namespace, :actions_generator

  def member(&block)
    Kawaii::Routing::Member.new(routes, self, &block)
  end

  def collection(&block)
    Kawaii::Routing::Collection.new(routes, self, &block)
  end

  def resource(resource_name, methods = nil, &block)
    Kawaii::Routing::Resource.new(routes, resource_name, methods, namespace, self, &block)
  end

  def resources(resources_name, methods = nil, &block)
    Kawaii::Routing::Resources.new(routes, resources_name, methods, namespace, self, &block)
  end

  def resource_path
    "/#{name}"
  end

  def resource_name
    "#{namespace}/#{name}"
  end

  protected

  def resource_full_path
     Kawaii::Routing::NestedPath.new(self).path
  end

  def generate_actions
    actions = actions_generator.new(resource_name, resource_full_path, @methods).call
    actions.each do |action|
      routes.send(action.http_method, action.path, action.mapping)
    end
  end
end
