module Kawaii
  class Controller
    def initialize(params, request)
      @params  = params
      @request = request
    end
    attr_reader :request, :params
  end
end
