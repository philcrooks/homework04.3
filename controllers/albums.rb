# NEW
get '/albums/new' do
  # Show the user a form to enter album details
  @action = "/albums"
  @button_text = "Create Album"
  @album = EmptyAlbum.new
  @artists = Artist.all
  erb( :"albums/form" )
end

# CREATE
post '/albums' do
  # The user has POSTed the albums NEW form
  @album = Album.new( params )
  @album.save
  @artist = Artist.by_id( @album.artist_id )
  erb( :"albums/create" )
end

# INDEX
get '/albums' do
  # The user wants to see all albums
  @albums = Album.all
  erb( :"albums/index")
end

# SHOW
get '/albums/:id' do
  # The user wants to see the details for one album
  id = params['id'].to_i
  @album = Album.by_id( id )
  @artist = Artist.by_id( @album.artist_id ) 
  erb ( :"albums/show")
end

# EDIT
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
post '/albums/:id' do
  @album = Album.new( params )
  @album.update
  redirect( to( "/albums/#{@album.id}" ) )
end

# DELETE
post '/albums/:id/delete' do
  Album.destroy( params['id'] )
  redirect( to( "/albums" ) )
end