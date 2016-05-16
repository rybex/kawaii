module Kawaii
  module Routing
    module Services
      class FindController
        def call(mapping)
          controller_name, method = parse_mapping(mapping)
          controller_class = find_controller(controller_name)
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
          mapping_with_namespace = mapping.split('/')
          namespace              = mapping_with_namespace[0] if mapping_with_namespace.length > 1
          controller, method     = mapping_with_namespace.last.split('#')
          [get_controller(namespace, controller), method.to_sym]
        end

        def get_controller(namespace, controller)
          controller_name = controller_name(controller)
          if namespace
            controller_name = wrap_namespace(namespace, controller_name)
          end
          controller_name
        end

        def controller_name(controller)
          "#{controller.capitalize}Controller"
        end

        def wrap_namespace(namespace, controller_name)
          "#{namespace.capitalize}::#{controller_name}"
        end
      end
    end
  end
end
