require 'rubygems'
require 'bundler'

require 'sqlite3/sqlite3_native' # This line shouldn't be here, but
                                 # sqlite3 crashes without it, due to
                                 # a missing method. (database.rb:293)

Bundler.require

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite")

class Comment
  include DataMapper::Resource
  property :id,   Serial
  property :name, String
  property :body, Text
end

DataMapper.finalize.auto_upgrade!

get '/' do
  @readme   = File.read('README.rdoc')
  @files    = Dir['./*']
  @comments = Comment.all
  haml :index
end

get '/style.css' do
  content_type 'text/css'
  sass :style
end

post '/comments' do
  @comment = Comment.new(:name => params[:name], :body => params[:body]) 
  @comment.save
  if request.xhr?
    @comment.to_json
  else
    redirect '/' 
  end
end
