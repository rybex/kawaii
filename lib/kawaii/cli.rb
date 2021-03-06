require 'thor'

module Kawaii
  class CLI < Thor

    desc 'new', 'Create new project structure'
    def new(name)
      new_project_generator(name).invoke_all
    end

    private

    def new_project_generator(name)
      Generators::NewProject.new([name])
    end
  end
end
