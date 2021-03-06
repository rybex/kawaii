require 'json'

module Kawaii
  module Routing
    class Handler
      def initialize(path, mapping, block = nil)
        @path    = path
        @mapping = mapping
        @handler = block || controller_handler(mapping)
      end

      def call(env)
        request  = rack_request(env)
        params   = get_url_params(request_path(env))
        response = call_handler(params, request)
        format_response(response)
      end

      private

      attr_reader :path, :mapping, :handler

      def controller_handler(mapping)
        Services::FindController.new.call(mapping)
      end

      def get_url_params(request_url)
        Services::ExtractParamsFromUrl.new.call(path, request_url)
      end

      def rack_request(env)
        Rack::Request.new(env)
      end

      def format_response(response)
        [
          200,
          {
            Rack::CONTENT_TYPE => 'application/json'
          },
          [response.to_json]
        ]
      end

      def call_handler(params, request)
        handler.call(params, request)
      end

      def request_path(env)
        env['PATH_INFO']
      end
    end
  end
end
