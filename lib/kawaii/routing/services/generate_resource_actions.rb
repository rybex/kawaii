module Kawaii
  module Routing
    module Services
      class GenerateResourceActions
        def initialize(name, path, methods)
          @name    = name.to_s
          @methods = methods
          @path    = path
        end

        def call
          methods.map do |method|
            send(method)
          end
        end

        protected

        def index
          get_action(name, :get, path.to_s, 'index')
        end

        def new
          get_action(name, :get, "#{path}/new", 'new')
        end

        def edit
          get_action(name, :get, "#{path}/edit", 'edit')
        end

        def create
          get_action(name, :post, path.to_s, 'create')
        end

        def update
          get_action(name, :put, path.to_s, 'update')
        end

        def destroy
          get_action(name, :delete, path.to_s, 'destroy')
        end

        def get_action(name, http_method, path_pattern, controller_method)
          Routing::Action.new(name, http_method, path_pattern, controller_method)
        end

        private

        attr_reader :methods, :name, :path
      end
    end
  end
end
