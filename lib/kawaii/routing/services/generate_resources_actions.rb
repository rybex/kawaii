module Kawaii
  module Routing
    module Services
      class GenerateResourcesActions < GenerateResourceActions
        def initialize(name, path, methods)
          @name    = name.to_s
          @methods = methods
          @path    = path
        end

        protected

        def show
          get_action(name, :get, "#{path}/:id", 'show')
        end

        def edit
          get_action(name, :get, "#{path}/:id/edit", 'edit')
        end

        def update
          get_action(name, :put, "#{path}/:id", 'update')
        end

        def destroy
          get_action(name, :delete, "#{path}/:id", 'destroy')
        end

        private

        attr_reader :methods, :name, :path
      end
    end
  end
end
