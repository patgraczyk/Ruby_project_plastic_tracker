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

#delete all tags
def self.delete_all
  sql = "DELETE FROM tags"
  SqlRunner.run(sql)
end

end #end of class
