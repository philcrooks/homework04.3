class DbAlbum

  def self.select( id = nil, field = "id" )
    sql = "SELECT * FROM albums"
    sql += " WHERE #{ field } = #{ id }" if id
    sql += " ORDER BY name ASC"
    return SqlRunner.run( sql )
  end

  def self.delete ( id = nil )
    sql = "DELETE FROM albums"
    sql += " WHERE id = #{ id }" if id
    SqlRunner.run( sql )
  end

  def self.save ( album )
    sql_fields = "INSERT INTO albums ("
    sql_values = ") VALUES ("
    album_hash = to_hash( album )
    for x, y in album_hash
      if x != "id"
        sql_fields += "#{x}, "
        sql_values += y.is_a?( Numeric ) ? "#{y}, " : "'#{y}', "
      end
    end
    sql = sql_fields[0..-3] + sql_values[0..-3] + ") RETURNING *"
    album = SqlRunner.run( sql ).first
    return album["id"]
  end

  def self.update ( album )
    sql_fields = "UPDATE albums SET ("
    sql_values = ") = ("
    album_hash = to_hash( album )
    for x, y in album_hash
      if x != "id"
        sql_fields += "#{x}, "
        sql_values += y.is_a?( Numeric ) ? "#{y}, " : "'#{y}', "
      end
    end
    sql = sql_fields[0..-3] + sql_values[0..-3] + ") WHERE id = #{album.id} RETURNING *"
    artist = SqlRunner.run( sql ).first
    return artist["id"]
  end

  private

  def self.to_hash ( album )
    hash = {}
    album.instance_variables.each {|var| hash[var.to_s.delete("@")] = album.instance_variable_get(var) }
    return hash
  end

end