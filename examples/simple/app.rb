require 'bundler'
Bundler.require

class Myapp < Savannah::Main
  def index
    Savannah::Response.new.tap do |response|
      response.body = "Hello there"
      response.status_code = 200
    end
  end
end
