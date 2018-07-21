require_relative( '../db/sql_runner' )

class Product

  attr_reader( :plastic_id, :tag_id, :id )
  attr_accessor( :name, :avoidability, :quantity)

def initialize( options )
  @id = options['id'].to_i
  @name = options['name']
  @avoidability = options['avoidability']
  @quantity = options['quantity'].to_i
  @plastic_id = options['plastic_id'].to_i
  @tag_id = options['tag_id'].to_i
end
