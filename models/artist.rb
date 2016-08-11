require_relative( '../db/db_artist' )
require_relative( '../models/album' )

class Artist

  def self.all()
    artists = DbArtist.select()
    return artists.map { |a| Artist.new( a ) }
  end

  def self.by_id( id )
    artists = DbArtist.select( id )
    return Artist.new( artists.first )
  end

  def self.destroy( id )
    DbArtist.delete( id )
  end

  attr_reader( :id, :name )

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    DbArtist.insert(self)
  end

  def update()
    DbArtist.update(self)
  end
end
