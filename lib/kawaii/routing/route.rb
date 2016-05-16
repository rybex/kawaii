class Kawaii::Routing::Route

  def initialize(path, http_method, mapping = nil, block = nil)
    @path        = path
    @http_method = http_method
    @mapping     = mapping
    @handler     = route_handler(path, mapping, block)
  end
  attr_reader :path, :mapping, :handler, :http_method

  def ==(other)
    return self.path == other.path && self.http_method == other.http_method
  end

  private

  def route_handler(path, mapping, block)
    Kawaii::Routing::Handler.new(path, mapping, block) if mapping || block
  end
end
