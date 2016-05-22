require 'spec_helper'

module Kawaii::Routing::Services
  describe ParseMapping do

    it 'parse mapping with controller and method' do
      mapping = 'test#simple_method'
      expect( parse(mapping) ).to eq ["TestController", :simple_method]
    end

    it 'parse mapping nested with namespaces' do
      mapping = 'namespace_one/namespace_two/test#simple_method'
      expect( parse(mapping) ).to eq ["NamespaceOne::NamespaceTwo::TestController", :simple_method]
    end

    private

    def parse(mapping)
      ParseMapping.new.call(mapping)
    end

  end
end
