require 'spec_helper'

module Kawaii::Routing
  describe Routes do

    it 'contain empty list of routes' do
      expect(Routes.routes.length).to eq 0
    end

    describe ":GET" do

      before(:each) do
        Routes.reset
      end

      it 'add new route to routes list with mapping' do
        Class.new(Routes) do
          get '/mapping_path', 'test#method'
        end
        route = Routes.routes.first

        verify_route(route, :GET, 'test#method', NilClass, '/mapping_path')
      end

      it 'add new route to routes list with blocak as handler' do
        Class.new(Routes) do
          get '/block_path' do
            'Hello world'
          end
        end
        route = Routes.routes.first

        verify_route(route, :GET, nil, Proc, '/block_path')
      end

      it 'raise exception if mapping and block set' do
        expect {
          Class.new(Routes) do
            get '/wrong_path', 'test#additional' do
              'Hello world'
            end
          end
        }.to raise_error(Kawaii::MappingAndBlockProvided, 'You cant provide mapping and block for route')
      end

      it 'raise exception if mapping and block are nil' do
        expect {
          Class.new(Routes) do
            get '/wrong_path'
          end
        }.to raise_error(Kawaii::MappingOrBlockMissing, 'You must provice block on mapping')
      end
    end

    describe ":POST" do

      before(:each) do
        Routes.reset
      end

      it 'add new route to routes list with mapping' do
        Class.new(Routes) do
          post '/mapping_path', 'test#method'
        end
        route = Routes.routes.first

        verify_route(route, :POST, 'test#method', NilClass, '/mapping_path')
      end

      it 'add new route to routes list with blocak as handler' do
        Class.new(Routes) do
          post '/block_path' do
            'Hello world'
          end
        end
        route = Routes.routes.first

        verify_route(route, :POST, nil, Proc, '/block_path')
      end

      it 'raise exception if mapping and block set' do
        expect {
          Class.new(Routes) do
            post '/wrong_path', 'test#additional' do
              'Hello world'
            end
          end
        }.to raise_error(Kawaii::MappingAndBlockProvided, 'You cant provide mapping and block for route')
      end

      it 'raise exception if mapping and block are nil' do
        expect {
          Class.new(Routes) do
            post '/wrong_path'
          end
        }.to raise_error(Kawaii::MappingOrBlockMissing, 'You must provice block on mapping')
      end
    end

    describe ":PUT" do

      before(:each) do
        Routes.reset
      end

      it 'add new route to routes list with mapping' do
        Class.new(Routes) do
          put '/mapping_path', 'test#method'
        end
        route = Routes.routes.first

        verify_route(route, :PUT, 'test#method', NilClass, '/mapping_path')
      end

      it 'add new route to routes list with blocak as handler' do
        Class.new(Routes) do
          put '/block_path' do
            'Hello world'
          end
        end
        route = Routes.routes.first

        verify_route(route, :PUT, nil, Proc, '/block_path')
      end

      it 'raise exception if mapping and block set' do
        expect {
          Class.new(Routes) do
            put '/wrong_path', 'test#additional' do
              'Hello world'
            end
          end
        }.to raise_error(Kawaii::MappingAndBlockProvided, 'You cant provide mapping and block for route')
      end

      it 'raise exception if mapping and block are nil' do
        expect {
          Class.new(Routes) do
            put '/wrong_path'
          end
        }.to raise_error(Kawaii::MappingOrBlockMissing, 'You must provice block on mapping')
      end
    end

    describe ":DELETE" do

      before(:each) do
        Routes.reset
      end

      it 'add new route to routes list with mapping' do
        Class.new(Routes) do
          delete '/mapping_path', 'test#method'
        end
        route = Routes.routes.first

        verify_route(route, :DELETE, 'test#method', NilClass, '/mapping_path')
      end

      it 'add new route to routes list with blocak as handler' do
        Class.new(Routes) do
          delete '/block_path' do
            'Hello world'
          end
        end
        route = Routes.routes.first

        verify_route(route, :DELETE, nil, Proc, '/block_path')
      end

      it 'raise exception if mapping and block set' do
        expect {
          Class.new(Routes) do
            delete '/wrong_path', 'test#additional' do
              'Hello world'
            end
          end
        }.to raise_error(Kawaii::MappingAndBlockProvided, 'You cant provide mapping and block for route')
      end

      it 'raise exception if mapping and block are nil' do
        expect {
          Class.new(Routes) do
            delete '/wrong_path'
          end
        }.to raise_error(Kawaii::MappingOrBlockMissing, 'You must provice block on mapping')
      end
    end

    describe "namespace" do
      before(:each) do
        Routes.reset
      end

      it 'add new routes with namespace added to path' do
        Class.new(Routes) do
          namespace :test_namespace do
            get    :get_path,    "test#get_action"
            post   :post_path,   "test#post_action"
            put    :put_path,    "test#put_action"
            delete :delete_path, "test#delete_action"
          end
        end

        expect(Routes.routes.length).to eq 4

        verify_route(Routes.routes[0], :GET,    'test_namespace/test#get_action',    NilClass, '/test_namespace/get_path')
        verify_route(Routes.routes[1], :POST,   'test_namespace/test#post_action',   NilClass, '/test_namespace/post_path')
        verify_route(Routes.routes[2], :PUT,    'test_namespace/test#put_action',    NilClass, '/test_namespace/put_path')
        verify_route(Routes.routes[3], :DELETE, 'test_namespace/test#delete_action', NilClass, '/test_namespace/delete_path')
      end
    end

    private

    def verify_route(route, method, mapping, handler_class, path)
      expect(route).to_not eq         nil
      expect(route.http_method).to eq method
      expect(route.mapping).to eq     mapping
      expect(route.handler).to be_an  handler_class
      expect(route.path).to eq        path
    end
  end
end
