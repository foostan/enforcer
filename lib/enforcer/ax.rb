require 'capistrano/all'
require 'capistrano/setup'
require 'capistrano/framework'
Dir.glob(File.expand_path('../../../lib', __FILE__) + '/enforcer/capistrano/tasks/*.rake').each { |r| p r; load r }

module Enforcer
  class Ax
    def initialize
    end

    def run(stage, task)
      Capistrano::Application.invoke(stage)
      Capistrano::Application.invoke(task)
    end
  end
end