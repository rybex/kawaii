class Kawaii::Routing::NestedPath
  def initialize(resource, action_class = nil)
    @resource     = resource
    @action_class = action_class
    @path         = wrap_namespace(resource, calculate(resource))
  end
  attr_reader :resource, :path, :action_class

  private

  def calculate(nested = nil, path = nil)
    unless path
      path = init_path
    else
      path.prepend nested.resource_path
    end
    calculate(nested.parent, path) if nested.parent
    path
  end

  def init_path
    if resource.class == Kawaii::Routing::Resources && action_class == Kawaii::Routing::Member
      resource_path
    else
      resource_name
    end
  end

  def resource_name
    "/#{resource.name}"
  end

  def resource_path
    resource.resource_path
  end

  def wrap_namespace(nested, path)
    if nested.namespace
      path.prepend "/#{nested.namespace}"
    end
    path
  end

end
