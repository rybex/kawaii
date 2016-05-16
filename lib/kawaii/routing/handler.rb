require 'json'

class Kawaii::Routing::Handler

  def initialize(path, mapping, block = nil)
    @path    = path
    @mapping = mapping
    @handler = block || controller_handler(mapping)
  end

  def call(env)
    request  = rack_request(env)
    params   = get_url_params(env['REQUEST_PATH'])
    response = handler.call(params, request)
    format_response(response)
  end

  private
  attr_reader :path, :mapping, :handler

  def controller_handler(mapping)
    Kawaii::Routing::Services::FindController.new.call(mapping)
  end

  def get_url_params(request_url)
    Kawaii::Routing::Services::ExtractParamsFromUrl.new.call(path, request_url)
  end

  def rack_request(env)
    Rack::Request.new(env)
  end

  def format_response(response)
    [
       200,
       {
         Rack::CONTENT_TYPE => 'application/json'
       },
       [response.to_json]
    ]
  end

end
