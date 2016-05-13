class Kawaii::Routing::Resources < Kawaii::Routing::Resource
  METHODS = [:index, :new, :show, :create, :edit, :update, :destroy]

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

  def resource_path
    "/#{name}/:#{name.to_s.split('/').last}_id"
  end

  def generate_actions
    actions = Kawaii::Routing::Services::GenerateResourcesActions.new(resource_name, Kawaii::Routing::NestedPath.new(self).path, @methods).call
    actions.each do |action|
      routes.send(action.http_method, action.path, action.mapping)
    end
  end
end
