class Kawaii::Routing::Resource
  METHODS = [:index, :new, :create, :edit, :update, :destroy]

  def initialize(routes, name, methods, namespace = nil, parent = nil, &block)
    @routes    = routes
    @name      = name
    @parent    = parent
    @methods   = methods || METHODS
    @namespace = namespace
    generate_actions
    instance_eval(&block) if block_given?
  end
  attr_reader :routes, :name, :parent, :namespace

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

  def generate_actions
    actions = Kawaii::Routing::Services::GenerateResourceActions.new(resource_name, Kawaii::Routing::NestedPath.new(self).path, @methods).call
    actions.each do |action|
      routes.send(action.http_method, action.path, action.mapping)
    end
  end
end
