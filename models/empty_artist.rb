require_relative( 'artist')

class EmptyArtist < Artist
  def initialize()
    super( {} )
  end

  def save()
    return nil
  end
end