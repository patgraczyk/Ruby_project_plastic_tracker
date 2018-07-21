require_relative( '../db/sql_runner' )

class Tag
  attr_reader :id
  attr_accessor :category

def initialize( options )
  @id = options['id'].to_i if options['id']
  @category=options['category']
end

#create new tag
def save( )
  sql = "INSERT INTO tags (category)
  VALUES ($1)
  RETURNING id"
  values = [@category]
  results = SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end

#update entry
def update( )
  sql = "UPDATE tags SET category = $1
  WHERE id = $2"
  values = [@category, @id]
  SqlRunner.run(sql, values)
end

#see all plastics associated with a specific tag
def plastics()
  sql = "SELECT plastics.* FROM plastics INNER JOIN products ON products.plastic_id = plastics.id WHERE products.tag_id = $1;"
  values= [@id]
  results= SqlRunner.run(sql, values)
  return results.map{|plastic| Plastic.new(plastic)}
end

#delete all tags
def self.delete_all
  sql = "DELETE FROM tags"
  SqlRunner.run(sql)
end

#delete by id
def delete()
  sql = "DELETE FROM tags WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql,values)
end

#find all tags
def self.all()
  sql = "SELECT * FROM tags"
  tags_data = SqlRunner.run(sql)
  tags = tags_data.map {|tag| Tag.new( tag)}
  return tags
end

#find by id - come back to write a function
def self.find( id )
  sql = "SELECT * FROM tags WHERE id = $1"
  values = [id]
  results = SqlRunner.run(sql, values)
  return Tag.new( results.first )
end


end #end of class
