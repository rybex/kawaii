module Kawaii
  class App

    def call(env)
      self.class.process_request(env)
    rescue Kawaii::RouteNotFound => error
      self.class.handle_route_not_found(error)
    end

    class << self

      def use(middleware, *args, &block)
        rack_builder.use(middleware, *args, &block)
      end

      def route_not_found(&block)
        @exception_handler = block
      end

      def process_request(env)
        route = router.match(env)
        rack_builder.run route.handler
        handler = rack_builder.to_app
        handler.call(env)
      end

      def rack_builder
        @rack_builder ||= Rack::Builder.new
      end

      def router
        @router ||= Router.new
      end

      def handle_route_not_found(error)
        handler = @exception_handler || error_handler(error)
        handler.call(error)
      end

      private

      def error_handler(error)
        Proc.new { raise error }
      end
    end
  end
end
