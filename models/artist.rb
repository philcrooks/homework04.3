require_relative( '../db/db_interface' )

class Artist
  TABLE = "artists"

  def self.all()
    artists = DbInterface.select( TABLE )
    return artists.map { |a| Artist.new( a ) }
  end

  def self.by_id( id )
    artists = DbInterface.select( TABLE, id )
    return Artist.new( artists.first )
  end

  def self.destroy( id )
    DbInterface.delete( TABLE, id )
  end

  attr_reader( :id, :name )

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    DbInterface.insert(TABLE, self)
  end

  def update()
    DbInterface.update(TABLE, self)
  end
end
