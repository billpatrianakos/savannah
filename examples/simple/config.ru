require 'bundler'
require './app'
Bundler.require

app = Myapp.new
app.router.config do
  get '/test', to: 'myapp#index'
end

run app
