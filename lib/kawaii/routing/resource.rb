module Kawaii
  module Routing
    class Resource
      METHODS = [:index, :new, :create, :edit, :update, :destroy].freeze

      def initialize(routes, name, methods, namespace = nil, parent = nil, &block)
        @routes            = routes
        @name              = name
        @parent            = parent
        @methods           = methods || METHODS
        @namespace         = namespace
        @block             = block
        @actions_generator = Services::GenerateResourceActions
        generate_actions
      end
      attr_reader :routes, :name, :parent, :namespace, :actions_generator, :block

      def generate
        instance_eval(block) if block
      end

      def member(&block)
        Member.new(routes, self, &block)
      end

      def collection(&block)
        Collection.new(routes, self, &block)
      end

      def resource(resource_name, methods = nil, &block)
        Resource.new(routes, resource_name, methods, namespace, self, &block)
      end

      def resources(resources_name, methods = nil, &block)
        Resources.new(routes, resources_name, methods, namespace, self, &block)
      end

      def resource_path
        "/#{name}"
      end

      def resource_name
        resource_name = name.to_s
        resource_name.prepend "#{namespace}/" if namespace
        resource_name
      end

      protected

      def resource_full_path
         NestedPath.new(self).path
      end

      def generate_actions
        actions = actions_generator.new(resource_name, resource_full_path, @methods).call
        actions.each do |action|
          routes.send(action.http_method, action.path, action.mapping)
        end
      end
    end
  end
end
