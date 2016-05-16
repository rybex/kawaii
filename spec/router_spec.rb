require 'spec_helper'

module Kawaii
  describe Router do

    let(:router)          { Router.new }
    let(:correct_request) { { 'REQUEST_PATH' => '/test_path', 'REQUEST_METHOD' => 'GET' } }
    let(:wrong_request)   { { 'REQUEST_PATH' => '/wrong_path', 'REQUEST_METHOD' => 'GET' } }

    before do
      Class.new(Kawaii::Routing::Routes) do
        get '/test_path', 'test#method'
      end
    end

    after do
      Kawaii::Routing::Routes.reset
    end

    it 'return route specified in Routes class' do
      route = router.match(correct_request)

      expect(route).to_not be         nil
      expect(route.http_method).to eq :GET
      expect(route.mapping).to eq     'test#method'
      expect(route.path).to eq        '/test_path'
    end

    it 'raise exception for not existing route' do
      expect {
        router.match(wrong_request)
      }.to raise_error(Kawaii::RouteNotFound, 'Please define route in routes file')
    end

  end
end
