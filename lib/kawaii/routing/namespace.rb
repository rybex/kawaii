module Kawaii
  module Routing
    class Namespace
      def initialize(routes, namespace_name, &block)
        @routes         = routes
        @namespace_name = namespace_name
        instance_eval(&block) if block_given?
      end

      def get(path, mapping)
        routes.get(namespace_path(path), wrap_in_namespace(mapping))
      end

      def post(path, mapping)
        routes.post(namespace_path(path), wrap_in_namespace(mapping))
      end

      def put(path, mapping)
        routes.put(namespace_path(path), wrap_in_namespace(mapping))
      end

      def delete(path, mapping)
        routes.delete(namespace_path(path), wrap_in_namespace(mapping))
      end

      def resource(resource_name, methods = nil, &block)
        Resource.new(routes, resource_name, methods, namespace_name, &block)
      end

      def resources(resources_name, methods = nil, &block)
        Resources.new(routes, resources_name, methods, namespace_name, &block)
      end

      private

      attr_reader :routes, :namespace_name

      def namespace_path(path)
        "/#{namespace_name}/#{path}"
      end

      def wrap_in_namespace(mapping)
        "#{namespace_name}/#{mapping}"
      end
    end
  end
end
