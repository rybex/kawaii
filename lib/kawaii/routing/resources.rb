module Kawaii
  module Routing
    class Resources < Resource
      METHODS = [:index, :new, :show, :create, :edit, :update, :destroy].freeze

      def initialize(routes, name, methods, namespace = nil, parent = nil, &block)
        @actions_generator = Services::GenerateResourcesActions
        super(routes, name, methods, namespace, parent, &block)
      end
      attr_reader :routes, :name, :parent, :namespace, :actions_generator, :block

      def generate
        instance_eval(block) if block
      end

      def resource_path
        "/#{name}/:#{name.to_s.split('/').last}_id"
      end
    end
  end
end
