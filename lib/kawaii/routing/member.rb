module Kawaii
  module Routing
    class Member
      def initialize(routes, resource, &block)
        @routes   = routes
        @path     = resource_path(resource)
        @resource = resource
        instance_eval(&block) if block_given?
      end

      def get(action_name)
        routes.get(member_path(action_name), member_mapping(action_name))
      end

      def post(action_name)
        routes.post(member_path(action_name), member_mapping(action_name))
      end

      def put(action_name)
        routes.put(member_path(action_name), member_mapping(action_name))
      end

      def delete(action_name)
        routes.delete(member_path(action_name), member_mapping(action_name))
      end

      protected

      def resource_path(resource)
        NestedPath.new(resource, self.class).path
      end

      def resource_name
        resource.resource_name
      end

      def member_path(action_name)
        "#{path}/#{action_name}"
      end

      def member_mapping(action_name)
        "#{resource_name}##{action_name}"
      end

      private

      attr_reader :routes, :path, :resource
    end
  end
end
