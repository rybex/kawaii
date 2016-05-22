module Kawaii
  module Routing
    module Services
      class ParseMapping
        def call(mapping)
          mapping_with_namespace = mapping.split('/')
          namespaces             = mapping_with_namespace[0..-2] if mapping_with_namespace.length > 1
          controller, method     = mapping_with_namespace.last.split('#')
          [get_controller(namespaces, controller), method.to_sym]
        end

        private

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

        def wrap_namespace(namespaces, controller_name)
          namespaces.reverse.each do |namespace|
            controller_name.prepend "#{titleize(namespace)}::"
          end
          controller_name
        end

        def titleize(namespace)
          namespace.split('_').map(&:capitalize).join('')
        end
      end
    end
  end
end
