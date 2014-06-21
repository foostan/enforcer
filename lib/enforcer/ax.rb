require 'capistrano/all'
require 'capistrano/setup'

module Enforcer
  class Ax
    def initialize
    end

    def run
      Capistrano::Application.invoke('test')
    end
  end
end