module Kawaii
  module Routing
    class Route
      def initialize(path, http_method, mapping = nil, block = nil)
        @path        = path
        @http_method = http_method
        @mapping     = mapping
        @handler     = route_handler(path, mapping, block)
      end
      attr_reader :path, :mapping, :handler, :http_method

      def ==(other)
        path == other.path && http_method == other.http_method
      end

      private

      def route_handler(path, mapping, block)
        Handler.new(path, mapping, block) if mapping || block
      end
    end
  end
end
