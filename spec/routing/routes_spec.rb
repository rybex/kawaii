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

      it 'allows to create nested resources' do
        Class.new(Routes) do
          namespace :test_namespace do
            resource  :wheel
            resources :door
          end
        end

        expect(Routes.routes.length).to eq 13

        verify_route(Routes.routes[0],  :GET,     'test_namespace/wheel#index',    NilClass, '/test_namespace/wheel')
        verify_route(Routes.routes[1],  :GET,     'test_namespace/wheel#new',      NilClass, '/test_namespace/wheel/new')
        verify_route(Routes.routes[2],  :POST,    'test_namespace/wheel#create',   NilClass, '/test_namespace/wheel')
        verify_route(Routes.routes[3],  :GET,     'test_namespace/wheel#edit',     NilClass, '/test_namespace/wheel/edit')
        verify_route(Routes.routes[4],  :PUT,     'test_namespace/wheel#update',   NilClass, '/test_namespace/wheel')
        verify_route(Routes.routes[5],  :DELETE,  'test_namespace/wheel#destroy',  NilClass, '/test_namespace/wheel')
        verify_route(Routes.routes[6],  :GET,     'test_namespace/door#index',     NilClass,  '/test_namespace/door')
        verify_route(Routes.routes[7],  :GET,     'test_namespace/door#new',       NilClass, '/test_namespace/door/new')
        verify_route(Routes.routes[8],  :GET,     'test_namespace/door#show',      NilClass, '/test_namespace/door/:id')
        verify_route(Routes.routes[9],  :POST,    'test_namespace/door#create',    NilClass, '/test_namespace/door')
        verify_route(Routes.routes[10], :GET,     'test_namespace/door#edit',      NilClass, '/test_namespace/door/:id/edit')
        verify_route(Routes.routes[11], :PUT,     'test_namespace/door#update',    NilClass, '/test_namespace/door/:id')
        verify_route(Routes.routes[12], :DELETE,  'test_namespace/door#destroy',   NilClass, '/test_namespace/door/:id')
      end
    end

    describe "resource" do
      before(:each) do
        Routes.reset
      end

      it 'creates all actions for specified resource' do
        Class.new(Routes) do
          resource :car
        end
        expect(Routes.routes.length).to eq 6

        verify_route(Routes.routes[0], :GET,    '/car#index',    NilClass, '/car')
        verify_route(Routes.routes[1], :GET,    '/car#new',      NilClass, '/car/new')
        verify_route(Routes.routes[2], :POST,   '/car#create',   NilClass, '/car')
        verify_route(Routes.routes[3], :GET,    '/car#edit',     NilClass, '/car/edit')
        verify_route(Routes.routes[4], :PUT,    '/car#update',   NilClass, '/car')
        verify_route(Routes.routes[5], :DELETE, '/car#destroy',  NilClass, '/car')
      end

      it 'creates all actions specified as parameter' do
        Class.new(Routes) do
          resource :car, [:index]
        end
        expect(Routes.routes.length).to eq 1

        verify_route(Routes.routes[0], :GET, '/car#index', NilClass, '/car')
      end

      it 'creates member actions for specific resource' do
        Class.new(Routes) do
          resource :car, [] do
            member do
              get    :get_path
              post   :post_path
              put    :put_path
              delete :delete_path
            end
          end
        end
        expect(Routes.routes.length).to eq 4

        verify_route(Routes.routes[0], :GET,    '/car#get_path',    NilClass, '/car/get_path')
        verify_route(Routes.routes[1], :POST,   '/car#post_path',   NilClass, '/car/post_path')
        verify_route(Routes.routes[2], :PUT,    '/car#put_path',    NilClass, '/car/put_path')
        verify_route(Routes.routes[3], :DELETE, '/car#delete_path', NilClass, '/car/delete_path')
      end

      it 'creates collection actions for specific resource' do
        Class.new(Routes) do
          resource :car, [] do
            collection do
              get    :get_path
              post   :post_path
              put    :put_path
              delete :delete_path
            end
          end
        end
        expect(Routes.routes.length).to eq 4

        verify_route(Routes.routes[0], :GET,    '/car#get_path',    NilClass, '/car/get_path')
        verify_route(Routes.routes[1], :POST,   '/car#post_path',   NilClass, '/car/post_path')
        verify_route(Routes.routes[2], :PUT,    '/car#put_path',    NilClass, '/car/put_path')
        verify_route(Routes.routes[3], :DELETE, '/car#delete_path', NilClass, '/car/delete_path')
      end

      it 'allows to create nested resources' do
        Class.new(Routes) do
          resource :car, [] do
            resource  :wheel
            resources :door
          end
        end
        expect(Routes.routes.length).to eq 13

        verify_route(Routes.routes[0],  :GET,     '/wheel#index',    NilClass, '/car/wheel')
        verify_route(Routes.routes[1],  :GET,     '/wheel#new',      NilClass, '/car/wheel/new')
        verify_route(Routes.routes[2],  :POST,    '/wheel#create',   NilClass, '/car/wheel')
        verify_route(Routes.routes[3],  :GET,     '/wheel#edit',     NilClass, '/car/wheel/edit')
        verify_route(Routes.routes[4],  :PUT,     '/wheel#update',   NilClass, '/car/wheel')
        verify_route(Routes.routes[5],  :DELETE,  '/wheel#destroy',  NilClass, '/car/wheel')
        verify_route(Routes.routes[6],  :GET,     '/door#index',     NilClass, '/car/door')
        verify_route(Routes.routes[7],  :GET,     '/door#new',       NilClass, '/car/door/new')
        verify_route(Routes.routes[8],  :GET,     '/door#show',      NilClass, '/car/door/:id')
        verify_route(Routes.routes[9],  :POST,    '/door#create',    NilClass, '/car/door')
        verify_route(Routes.routes[10], :GET,     '/door#edit',      NilClass, '/car/door/:id/edit')
        verify_route(Routes.routes[11], :PUT,     '/door#update',    NilClass, '/car/door/:id')
        verify_route(Routes.routes[12], :DELETE,  '/door#destroy',   NilClass, '/car/door/:id')
      end
    end

    describe "resources" do
      before(:each) do
        Routes.reset
      end

      it 'creates all actions for specified resource' do
        Class.new(Routes) do
          resources :car
        end
        expect(Routes.routes.length).to eq 7

        verify_route(Routes.routes[0], :GET,    '/car#index',    NilClass, '/car')
        verify_route(Routes.routes[1], :GET,    '/car#new',      NilClass, '/car/new')
        verify_route(Routes.routes[2], :GET,    '/car#show',     NilClass, '/car/:id')
        verify_route(Routes.routes[3], :POST,   '/car#create',   NilClass, '/car')
        verify_route(Routes.routes[4], :GET,    '/car#edit',     NilClass, '/car/:id/edit')
        verify_route(Routes.routes[5], :PUT,    '/car#update',   NilClass, '/car/:id')
        verify_route(Routes.routes[6], :DELETE, '/car#destroy',  NilClass, '/car/:id')
      end

      it 'creates all actions specified as parameter' do
        Class.new(Routes) do
          resources :car, [:index]
        end
        expect(Routes.routes.length).to eq 1

        verify_route(Routes.routes[0], :GET, '/car#index', NilClass, '/car')
      end

      it 'creates member actions for specific resource' do
        Class.new(Routes) do
          resources :car, [] do
            member do
              get    :get_path
              post   :post_path
              put    :put_path
              delete :delete_path
            end
          end
        end
        expect(Routes.routes.length).to eq 4

        verify_route(Routes.routes[0], :GET,    '/car#get_path',    NilClass, '/car/:car_id/get_path')
        verify_route(Routes.routes[1], :POST,   '/car#post_path',   NilClass, '/car/:car_id/post_path')
        verify_route(Routes.routes[2], :PUT,    '/car#put_path',    NilClass, '/car/:car_id/put_path')
        verify_route(Routes.routes[3], :DELETE, '/car#delete_path', NilClass, '/car/:car_id/delete_path')
      end

      it 'creates collection actions for specific resource' do
        Class.new(Routes) do
          resources :car, [] do
            collection do
              get    :get_path
              post   :post_path
              put    :put_path
              delete :delete_path
            end
          end
        end
        expect(Routes.routes.length).to eq 4

        verify_route(Routes.routes[0], :GET,    '/car#get_path',    NilClass, '/car/get_path')
        verify_route(Routes.routes[1], :POST,   '/car#post_path',   NilClass, '/car/post_path')
        verify_route(Routes.routes[2], :PUT,    '/car#put_path',    NilClass, '/car/put_path')
        verify_route(Routes.routes[3], :DELETE, '/car#delete_path', NilClass, '/car/delete_path')
      end

      it 'allows to create nested resources' do
        Class.new(Routes) do
          resources :car, [] do
            resource  :wheel
            resources :door
          end
        end

        expect(Routes.routes.length).to eq 13

        verify_route(Routes.routes[0], :GET,     '/wheel#index',    NilClass, '/car/:car_id/wheel')
        verify_route(Routes.routes[1], :GET,     '/wheel#new',      NilClass, '/car/:car_id/wheel/new')
        verify_route(Routes.routes[2], :POST,    '/wheel#create',   NilClass, '/car/:car_id/wheel')
        verify_route(Routes.routes[3], :GET,     '/wheel#edit',     NilClass, '/car/:car_id/wheel/edit')
        verify_route(Routes.routes[4], :PUT,     '/wheel#update',   NilClass, '/car/:car_id/wheel')
        verify_route(Routes.routes[5], :DELETE,  '/wheel#destroy',  NilClass, '/car/:car_id/wheel')
        verify_route(Routes.routes[6], :GET,     '/door#index',     NilClass, '/car/:car_id/door')
        verify_route(Routes.routes[7], :GET,     '/door#new',       NilClass, '/car/:car_id/door/new')
        verify_route(Routes.routes[8], :GET,     '/door#show',      NilClass, '/car/:car_id/door/:id')
        verify_route(Routes.routes[9], :POST,    '/door#create',    NilClass, '/car/:car_id/door')
        verify_route(Routes.routes[10], :GET,    '/door#edit',      NilClass, '/car/:car_id/door/:id/edit')
        verify_route(Routes.routes[11], :PUT,    '/door#update',    NilClass, '/car/:car_id/door/:id')
        verify_route(Routes.routes[12], :DELETE, '/door#destroy',   NilClass, '/car/:car_id/door/:id')
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
