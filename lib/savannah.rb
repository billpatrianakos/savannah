require "savannah/version"
require 'rack'

module Savannah
  class Main
    def call(env)
      [200, {}, ["Hello", "Whatever"]]
    end
  end
end
