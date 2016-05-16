module Kawaii
  module Routing
    class Resources < Resource
      METHODS = [:index, :new, :show, :create, :edit, :update, :destroy].freeze

      def initialize(routes, name, methods, namespace = nil, parent = nil, &block)
        @routes            = routes
        @name              = name
        @parent            = parent
        @methods           = methods || METHODS
        @namespace         = namespace
        @actions_generator = Services::GenerateResourcesActions
        generate_actions
        instance_eval(&block) if block_given?
      end
      attr_reader :routes, :name, :parent, :namespace, :actions_generator

      def resource_path
        "/#{name}/:#{name.to_s.split('/').last}_id"
      end
    end
  end
end
