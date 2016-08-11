require_relative( 'sql_runner' )

class DbInterface
  def self.select( table, id = nil, field = "id" )
    sql = "SELECT * FROM #{table}"
    sql += " WHERE #{ field } = #{ id }" if id
    sql += " ORDER BY name ASC"
    return SqlRunner.run( sql )
  end

  def self.delete ( table, id = nil )
    sql = "DELETE FROM #{table}"
    sql += " WHERE id = #{ id }" if id
    SqlRunner.run( sql )
  end

  def self.insert ( table, object )
    sql_fields = "INSERT INTO #{table} ("
    sql_values = ") VALUES ("
    hash = to_hash( object )
    for x, y in hash
      if x != "id"
        sql_fields += "#{x}, "
        sql_values += y.is_a?( Numeric ) ? "#{y}, " : "'#{y}', "
      end
    end
    sql = sql_fields[0..-3] + sql_values[0..-3] + ") RETURNING *"
    result = SqlRunner.run( sql ).first
    return result["id"].to_i
  end

  def self.update ( table, object )
    sql_fields = "UPDATE #{table} SET ("
    sql_values = ") = ("
    hash = to_hash( object )
    for x, y in hash
      if x != "id"
        sql_fields += "#{x}, "
        sql_values += y.is_a?( Numeric ) ? "#{y}, " : "'#{y}', "
      end
    end
    sql = sql_fields[0..-3] + sql_values[0..-3] + ") WHERE id = #{object.id} RETURNING *"
    result = SqlRunner.run( sql ).first
    return result["id"].to_i
  end

  private

  def self.to_hash ( object )
    hash = {}
    object.instance_variables.each {|var| hash[var.to_s.delete("@")] = object.instance_variable_get(var) }
    return hash
  end
end