module Kawaii
  module Routing
    module Services
      class GenerateResourcesActions

        def initialize(name, path, methods)
          @name    = name.to_s
          @methods = methods
          @path = path
        end

        def call
          methods.map do |method|
            send(method)
          end
        end

        private
        attr_reader :methods, :name, :path

        def index
          get_action(name, :get, "#{path}", 'index')
        end

        def new
          get_action(name, :get, "#{path}/new", 'new')
        end

        def show
          get_action(name, :get, "#{path}/:id", 'show')
        end

        def edit
          get_action(name, :get, "#{path}/:id/edit", 'edit')
        end

        def create
          get_action(name, :post, "#{path}", 'create')
        end

        def update
          get_action(name, :put, "#{path}/:id", 'update')
        end

        def destroy
          get_action(name, :delete, "#{path}/:id", 'destroy')
        end

        def get_action(name, http_method, path_pattern, controller_method)
          Kawaii::Routing::Action.new(name, http_method, path_pattern, controller_method)
        end
      end
    end
  end
end
