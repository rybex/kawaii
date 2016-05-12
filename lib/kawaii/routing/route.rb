class Kawaii::Routing::Route

  def initialize(path, http_method, mapping = nil, handler = nil)
    @path        = path
    @http_method = http_method
    @mapping     = mapping
    @handler     = handler
  end
  attr_reader :path, :mapping, :handler, :http_method

end
