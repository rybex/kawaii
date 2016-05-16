module Kawaii
  class MappingAndBlockProvided < StandardError
    def message
      'You cant provide mapping and block for route'
    end
  end

  class MappingOrBlockMissing < StandardError
    def message
      'You must provice block on mapping'
    end
  end

  class MissingBlockForNamespace < StandardError
    def message
      'You must provide block for namespace'
    end
  end

  class ControllerDoesntExist < StandardError
    def message
      'Create controller endpoint for specified route'
    end
  end

  class RouteNotFound < StandardError
    def message
      'Please define route in routes file'
    end
  end
end
