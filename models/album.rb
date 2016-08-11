require_relative('../db/db_interface')

class Album
  TABLE = "albums"

  def self.all()
    albums = DbInterface.select( TABLE ) 
    return albums.map { |a| Album.new( a ) }
  end

  def self.by_id ( id )
    albums = DbInterface.select( TABLE, id ) 
    return Album.new(albums.first)
  end

  def self.by_artist( id )
    albums = DbInterface.select( TABLE, id, "artist_id" ) 
    return albums.map { |a| Album.new( a ) }
  end

  def self.destroy( id )
    DbInterface.delete( DB_NAME, id )
  end

  attr_reader( :id, :name, :year, :artist_id )

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @year = options['year'].to_i
    @artist_id = options['artist_id'].to_i
  end

  def save()
    DbInterface.insert( TABLE, self )
  end

  def update()
    DbInterface.update( TABLE, self )
  end

end
