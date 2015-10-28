require "savannah/version"
require 'rack'

module Savannah
  class Main
    attr_accessor :router

    def initialize(env={})
      @router = Router.new
    end

    def call(env)
      route = @router.route_for(env)
      if route
        response = route.execute(env)
        response.rack_response
      else
        [404, {}, ["Page not found"]]
      end
    end
  end

  class Response
    attr_accessor :status_code, :headers, :body

    def initialize
      @headers = {}
    end

    def rack_response
      [status_code, headers, Array(body)]
    end
  end

  class Router
    attr_reader :routes

    def initialize
      @routes = Hash.new { |hash, key| hash[key] = [] }
    end

    def config(&block)
      instance_eval &block
    end

    def route_for(env)
      path   = env["PATH_INFO"]
      method = env["REQUEST_METHOD"].downcase.to_sym
      route_array = @routes[method].detect do |route|
        case route.first
        when String
          path == route.first
        when Regexp
          path =~ route.first
        end
      end

      return Route.new(route_array) if route_array
      return nil #No route matched
    end

    def get(path, options = {})
      @routes[:get] << [path, parse_to(options[:to])]
    end

    private
      def parse_to(controller_action)
        klass, method = controller_action.split('#')
        { klass: klass.capitalize, method: method }
      end
  end

  class Route
    attr_accessor :klass_name, :path, :instance_method

    def initialize(route_array)
      @path            = route_array.first
      @klass_name      = route_array.last[:klass]
      @instance_method = route_array.last[:method]
      #handle_requires
    end

    def klass
      Module.const_get(@klass_name)
    end

    def execute(env)
      klass.new(env).send(@instance_method.to_sym)
    end

    def handle_requires
      require File.join(File.dirname(__FILE__), '../', 'app', 'controllers', klass_name.downcase + '.rb')
    end
  end
end
