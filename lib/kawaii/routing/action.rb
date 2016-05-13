class Kawaii::Routing::Action
  def initialize(name, http_method, path_pattern, controller_method)
    @http_method = http_method
    @path        = path_pattern
    @mapping     = generate_mapping(name, controller_method)
  end
  attr_reader :http_method, :path, :mapping

  private

  def generate_path(path_pattern, name)
    path_pattern % [name]
  end

  def generate_mapping(name, controller_method)
    "#{name}##{controller_method}"
  end

end
