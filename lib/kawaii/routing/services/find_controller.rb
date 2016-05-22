module Kawaii
  module Routing
    module Services
      class FindController
        def call(mapping)
          controller_name, method = parse_mapping(mapping)
          controller_class        = find_controller(controller_name)
          proc do |params, request|
            raise ControllerDoesntExist if controller_class.nil?
            controller = controller_class.new(params, request)
            controller.send(method)
          end
        end

        private

        def find_controller(controller_name)
          Object.const_get(controller_name)
        rescue
          nil
        end

        def parse_mapping(mapping)
          ParseMapping.new.call(mapping)
        end
      end
    end
  end
end
