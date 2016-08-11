require_relative( 'album')

class EmptyAlbum < Album
  def initialize()
    super( {} )
  end

  def save()
    return nil
  end
end