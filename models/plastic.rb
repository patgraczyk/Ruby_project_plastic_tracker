require_relative( '../db/sql_runner' )

class Plastic
  attr_reader :id
  attr_accessor :type, :existence, :weight, :conversion_factor, :recycable

def initialize( options )
  @id = options['id'].to_i if options['id']
  @type = options['type']
  @existence = options['existence'].to_i
  @weight = options['weight'].to_i
  @conversion_factor = options['conversion_factor'].to_f
  @recycable= options['recycable']
end

#create new plastic type


def save()
  sql = "INSERT INTO plastics (type, existence, weight, conversion_factor, recycable) VALUES ($1, $2, $3, $4, $5)
  RETURNING id"
  values=[@type, @existence, @weight, @conversion_factor, @recycable]
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
  sql = "UPDATE plastics SET (type, existence, weight, conversion_factor, recycable) = ($1, $2, $3, $4, $5)
  WHERE id = $6"
  values = [@type, @existence, @weight, @conversion_factor, @recycable, @id]
  SqlRunner.run(sql, values)
end

#find all plastics
def self.all()
  sql = "SELECT * FROM plastics"
  plastics_data = SqlRunner.run(sql)
  plastics = plastics_data.map {|plastic| Plastic.new( plastic)}
  return plastics
end

#calculate total weight of items - Did I actually need it?
def self.weight()
  sql = "SELECT SUM(weight) FROM plastics"
  results= SqlRunner.run(sql)
  return results.first['sum'].to_i
end

#calculate until when will the plastic be on the planet
def biodegrate()
  sql = 'SELECT existence FROM plastics WHERE id=$1'
  values=[@id]
  results= SqlRunner.run(sql, values)
  return results.first['existence'].to_i + 2018
  #2018 hard coded at the moment, will change to use as a current year from SQL
end

def self.find( id )
  sql = "SELECT * FROM plastics WHERE id = $1"
  values = [id]
  results = SqlRunner.run(sql, values)
  return Plastic.new( results.first )
end

end #end of class
