require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('models/artist')
require_relative('models/album')
require_relative('models/empty_artist')
require_relative('models/empty_album')

get '/' do
  redirect( to( "/artists" ))
end

# NEW
get '/artists/new' do
  # Show the user a form to enter artist details
  @action = "/artists"
  @button_text = "Create Artist"
  @artist = EmptyArtist.new
  erb( :"artists/form" )
end

get '/albums/new' do
  # Show the user a form to enter album details
  @action = "/albums"
  @button_text = "Create Album"
  @album = EmptyAlbum.new
  @artists = Artist.all
  erb( :"albums/form" )
end

# CREATE
post '/artists' do
  # The user has POSTed the artists NEW form
  @artist = Artist.new( params )
  @artist.save
  erb( :"artists/create" )
end

post '/albums' do
  # The user has POSTed the albums NEW form
  @album = Album.new( params )
  @album.save
  @artist = Artist.by_id( @album.artist_id )
  erb( :"albums/create" )
end

# INDEX
get '/artists' do
  # The user wants to see all artists
  @artists = Artist.all
  erb( :"artists/index")
end

get '/albums' do
  # The user wants to see all albums
  @albums = Album.all
  erb( :"albums/index")
end

# SHOW
get '/artists/:id' do
  # The user wants to see the details for one artist
  id = params['id'].to_i
  @artist = Artist.by_id( id )
  @albums = Album.by_artist( @artist.id )
  erb ( :"artists/show")
end

get '/albums/:id' do
  # The user wants to see the details for one album
  id = params['id'].to_i
  @album = Album.by_id( id )
  @artist = Artist.by_id( @album.artist_id ) 
  erb ( :"albums/show")
end

# EDIT
get '/artists/:id/edit' do
  # Show the user a form to edit artist details
  id = params['id'].to_i
  @action = "/artists/#{id}"
  @button_text = "Update Artist"
  @artist = Artist.by_id( id )
  erb( :"artists/form" )
end

get '/albums/:id/edit' do
  # Show the user a form to edit album details
  id = params['id'].to_i
  @action = "/albums/#{id}"
  @button_text = "Update Album"
  @album = Album.by_id( id )
  @artists = Artist.all
  erb( :"albums/form" )
end

# UPDATE
post '/artists/:id' do
  @artist = Artist.new( params )
  @artist.update
  redirect( to( "/artists/#{@artist.id}" ) )
end

post '/albums/:id' do
  @album = Album.new( params )
  @album.update
  redirect( to( "/albums/#{@album.id}" ) )
end

# DELETE
post '/artists/:id/delete' do
  Artist.destroy( params['id'] )
  redirect( to( "/artists" ) )
end

post '/albums/:id/delete' do
  Album.destroy( params['id'] )
  redirect( to( "/albums" ) )
end