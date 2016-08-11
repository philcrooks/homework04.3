require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('models/artist')
require_relative('models/album')
require_relative('models/empty_artist')
require_relative('models/empty_album')
require_relative('controllers/albums')
require_relative('controllers/artists')

get '/' do
  redirect( to( "/artists" ))
end