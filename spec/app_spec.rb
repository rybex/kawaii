require 'spec_helper'
require 'json'

Class.new(Kawaii::Routing::Routes) do
  get '/test_path' do
    { message: 'Hello test' }
  end
end

module Kawaii
  describe App do

    after(:all) do
      Kawaii::Routing::Routes.reset
    end

    describe 'Process request' do
      let(:app) { App.new }

      it 'return success response' do
        get '/test_path'

        expect(last_response).to be_ok
        expect(JSON.parse(last_response.body)).to include({ 'message' => 'Hello test' })
      end

      it 'return exception if route not exist' do
        expect { get '/wrong_path' }.to raise_error Kawaii::RouteNotFound
      end
    end

    describe 'Use customer Rack middleware' do
      class ModifyResponse
        def initialize(app)
          @app = app
        end
        attr_reader :app

        def call(env)
          status, headers, response = app.call(env)
          response[0] = {message: 'Modified hello'}.to_json
          [status, headers, response]
        end
      end

      class Application < Kawaii::App
        use ModifyResponse
      end

      let(:app) { Application.new }

      it 'uses the custom handler' do
        get '/test_path'

        expect(last_response).to be_ok
        expect(JSON.parse(last_response.body)).to include({ 'message' => 'Modified hello' })
      end
    end

    describe 'Define custom 404 exception handler' do

      class Application < Kawaii::App
        route_not_found do
          [404, {Rack::CONTENT_TYPE => "application/json"}, [{ message: 'Route not exists'}.to_json]]
        end
      end

      let(:app) { Application.new }

      it 'uses the custom handler' do
        get '/wrong_path'

        expect(last_response.status).to eq 404
        expect(JSON.parse(last_response.body)).to include({ 'message' => 'Route not exists' })
      end
    end

  end
end
