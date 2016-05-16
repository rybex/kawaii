module Kawaii
  class Router
    def initialize
      @routes = Routing::Routes.routes
    end

    def match(env)
      searched_route = create_route(env)
      route          = find_route(searched_route)
      raise RouteNotFound unless route
      route
    end

    private

    attr_reader :routes

    def find_route(searched_route)
      routes.detect { |route| route == searched_route }
    end

    def create_route(env)
      Routing::Route.new(request_path(env), request_method(env))
    end

    def request_path(env)
      env['REQUEST_PATH']
    end

    def request_method(env)
      env['REQUEST_METHOD'].to_sym
    end
  end
end
