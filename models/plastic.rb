require_relative( '../db/sql_runner' )

class Plastic
  attr_reader :id
  attr_accessor :type, :existence, :weight

def initialize( options )
  @id = options['id'].to_i if options['id']
  @type = options['type']
  @existence = options['existence'].to_i
  @weight = options['weight'].to_i
end

#create new plastic type
def save()
  sql = "INSERT INTO plastics (type, existence, weight) VALUES ($1, $2, $3)
  RETURNING id"
  values=[@type, @existence, @weight]
  results = SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end

#delete by id
def delete()
  sql = "DELETE FROM plastics WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql,values)
end

#see all tags associated with a specific plastic
def tags()
  sql = "SELECT t.* FROM tags t INNER JOIN products p ON p.tag_id = t.id WHERE p.plastic_id = $1;"
  values= [@id]
  results= SqlRunner.run(sql, values)
  return results.map{|tag| Tag.new(tag)}
end

#delete all plastic types
def self.delete_all
  sql = "DELETE FROM plastics"
  SqlRunner.run(sql)
end

#update entry
def update( )
  sql = "UPDATE plastics SET (type, existence, weight) = ($1, $2, $3)
  WHERE id = $4"
  values = [@type, @existence, @weight, @id]
  SqlRunner.run(sql, values)
end

#find all plastics
def self.all()
  sql = "SELECT * FROM plastics"
  plastics_data = SqlRunner.run(sql)
  plastics = plastics_data.map {|plastic| Plastic.new( plastic)}
  return plastics
end


end #end of class
