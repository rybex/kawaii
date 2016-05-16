module Kawaii
  class App

    def call(env)
      self.class.process_request(env)
    rescue => error
      self.class.handle_exception(error)
    end

    class << self

      def use(middleware, *args, &block)
        rack_builder.use(middleware, *args, &block)
      end

      def custom_exception(&block)
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
        @router ||= Kawaii::Router.new
      end

      def handle_exception(error)
        handler = @exception_handler || error_handler(error)
        handler.call(error)
      end

      private

      def error_handler(error)
        Proc.new (error) { raise error }
      end
    end
  end
end
