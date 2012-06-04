require 'rubygems'
require 'bundler'

Bundler.require

get '/' do
  @readme = File.read('README.rdoc')
  haml :index
end

get '/style.css' do
  content_type 'text/css'
  sass :style
end
