require_relative( 'sql_runner' )

class DbArtist
  def self.select( id = nil )
    sql = "SELECT * FROM artists"
    sql += " WHERE id = #{ id }" if id
    sql += " ORDER BY name ASC"
    return SqlRunner.run( sql )
  end

  def self.delete ( id = nil )
    sql = "DELETE FROM artists"
    sql += " WHERE id = #{ id }" if id
    SqlRunner.run( sql )
  end

  def self.save ( artist )
    sql_fields = "INSERT INTO artists ("
    sql_values = ") VALUES ("
    artist_hash = to_hash( artist )
    for x, y in artist_hash
      if x != "id"
        sql_fields += "#{x}, "
        sql_values += y.is_a?( Numeric ) ? "#{y}, " : "'#{y}', "
      end
    end
    sql = sql_fields[0..-3] + sql_values[0..-3] + ") RETURNING *"
    artist = SqlRunner.run( sql ).first
    return artist["id"].to_i
  end

  def self.update ( artist )
    sql_fields = "UPDATE artists SET ("
    sql_values = ") = ("
    artist_hash = to_hash( artist )
    for x, y in artist_hash
      if x != "id"
        sql_fields += "#{x}, "
        sql_values += y.is_a?( Numeric ) ? "#{y}, " : "'#{y}', "
      end
    end
    sql = sql_fields[0..-3] + sql_values[0..-3] + ") WHERE id = #{artist.id} RETURNING *"
    artist = SqlRunner.run( sql ).first
    return artist["id"].to_i
  end

  private

  def self.to_hash ( artist )
    hash = {}
    artist.instance_variables.each {|var| hash[var.to_s.delete("@")] = artist.instance_variable_get(var) }
    return hash
  end
end