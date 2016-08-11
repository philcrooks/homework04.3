require_relative('../db/db_album')

class Album

  def self.all()
    albums = DbAlbum.select() 
    return albums.map { |a| Album.new( a ) }
  end

  def self.by_id ( id )
    albums = DbAlbum.select( id ) 
    return Album.new(albums.first)
  end

  def self.by_artist( id )
    albums = DbAlbum.select( id, "artist_id" ) 
    return albums.map { |a| Album.new( a ) }
  end

  def self.destroy( id )
    DbAlbum.delete( id )
  end

  attr_reader( :id, :name, :year, :artist_id )

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @year = options['year'].to_i
    @artist_id = options['artist_id'].to_i
  end

  def save()
    DbAlbum.insert(self)
  end

  def update( id )
    DbAlbum.update(self)
  end

end
