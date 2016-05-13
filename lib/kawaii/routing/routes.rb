module Kawaii
  module Routing
    class Routes
      @@routes ||= []

      class << self

        def get(path, mapping = nil, &block)
          create_route(path, mapping, :GET, block)
        end

        def post(path, mapping = nil, &block)
          create_route(path, mapping, :POST, block)
        end

        def put(path, mapping = nil, &block)
          create_route(path, mapping, :PUT, block)
        end

        def delete(path, mapping = nil, &block)
          create_route(path, mapping, :DELETE, block)
        end

        def resources(name, methods = nil, &block)
          Kawaii::Routing::Resources.new(self, name, methods, &block)
        end

        def resource(name, methods = nil, &block)
          Kawaii::Routing::Resource.new(self, name, methods, &block)
        end

        def namespace(name, &block)
          Kawaii::Routing::Namespace.new(self, name, &block)
        end

        def routes
          @@routes
        end

        def reset
          @@routes = []
        end

        private

        def create_route(path, mapping, http_method, block)
          validate_arguments(mapping, block)
          add_route_to_list(route(path, mapping, http_method, block))
        end

        def validate_arguments(mapping, block)
          raise MappingAndBlockProvided if mapping && block
          raise MappingOrBlockMissing   unless mapping || block
        end

        def add_route_to_list(route)
          @@routes.push(route)
        end

        def route(path, mapping, http_method, block)
          Kawaii::Routing::Route.new(path, http_method, mapping, block)
        end

      end
    end
  end
end
