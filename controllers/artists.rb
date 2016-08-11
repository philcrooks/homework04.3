# NEW
get '/artists/new' do
  # Show the user a form to enter artist details
  @action = "/artists"
  @button_text = "Create Artist"
  @artist = EmptyArtist.new
  erb( :"artists/form" )
end

# CREATE
post '/artists' do
  # The user has POSTed the artists NEW form
  @artist = Artist.new( params )
  @artist.save
  erb( :"artists/create" )
end

# INDEX
get '/artists' do
  # The user wants to see all artists
  @artists = Artist.all
  erb( :"artists/index")
end

# SHOW
get '/artists/:id' do
  # The user wants to see the details for one artist
  id = params['id'].to_i
  @artist = Artist.by_id( id )
  @albums = Album.by_artist( @artist.id )
  erb ( :"artists/show")
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

# UPDATE
post '/artists/:id' do
  @artist = Artist.new( params )
  @artist.update
  redirect( to( "/artists/#{@artist.id}" ) )
end

# DELETE
post '/artists/:id/delete' do
  Artist.destroy( params['id'] )
  redirect( to( "/artists" ) )
end