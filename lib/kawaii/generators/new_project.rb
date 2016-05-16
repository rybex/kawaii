require 'thor'

module Kawaii
  module Generators
    class NewProject < Thor::Group
      include Thor::Actions

      TEMPLATES_DIR = 'templates/new_project'.freeze

      argument :name

      def self.source_root
        File.dirname(__FILE__)
      end

      def create_gemfile
        template(gemfile_template_location, gemfile_file_name)
      end

      def create_application_rb
        template(application_template_location, application_file_name)
      end

      def create_config_ru
        template(config_ru_template_location, config_ru_file_name)
      end

      def create_routes_ru
        template(routes_template_location, routes_file_name)
      end

      def create_app_folder
        empty_directory app_file_name
      end

      private

      def gemfile_template_location
        "#{TEMPLATES_DIR}/Gemfile.erb"
      end

      def application_template_location
        "#{TEMPLATES_DIR}/application.rb.erb"
      end

      def config_ru_template_location
        "#{TEMPLATES_DIR}/config.ru.erb"
      end

      def routes_template_location
        "#{TEMPLATES_DIR}/routes.rb.erb"
      end

      def gemfile_file_name
        "#{name}/Gemfile"
      end

      def application_file_name
        "#{name}/application.rb"
      end

      def config_ru_file_name
        "#{name}/config.ru"
      end

      def routes_file_name
        "#{name}/config/routes.rb"
      end

      def app_file_name
        "#{name}/app"
      end
    end
  end
end
