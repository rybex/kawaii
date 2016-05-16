module Kawaii
  module Routing
    class Collection < Member
      def initialize(routes, resource, &block)
        @routes   = routes
        @path     = resource_path(resource)
        @resource = resource
        instance_eval(&block) if block_given?
      end

      private

      attr_reader :routes, :path, :parent_name
    end
  end
end
