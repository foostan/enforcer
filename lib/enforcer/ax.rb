require 'capistrano/all'
require 'capistrano/setup'
require 'capistrano/framework'
require 'attender'
Dir.glob(File.expand_path('../../../lib', __FILE__) + '/enforcer/capistrano/tasks/*.rake').each { |r| load r }

module Enforcer
  class Ax
    def initialize
      @request_queue = Queue.new
      STDOUT.sync = true
      Thread.abort_on_exception = true
    end

    def run


      getter = Thread.new do
        loop do
          while line = STDIN.gets
            @request_queue << line
          end
        end
      end

      runner = Thread.new do
        loop do
          unless @request_queue.empty?
            request = @request_queue.pop.split(/\s/)

            type = request[0] == '+' ? 'pass' : 'fail'
            node_name = request[1]
            check_id = request[2]
            stage = 'test'
            task = "#{type}:#{check_id}"

            Capistrano::Application.invoke(stage)
            Capistrano::Application.invoke(task, node_name)
          end
          sleep rand * 0.1
        end
      end

      getter.join
      runner.join

    end


  end
end