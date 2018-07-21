require_relative( '../db/sql_runner' )

class Product

  attr_reader( :plastic_id, :tag_id, :id )
  attr_accessor( :name, :avoidability, :quantity)

def initialize( options )
  @id = options['id'].to_i
  @name = options['name']
  @avoidability= options['avoidability']
  @quantity = options['quantity'].to_i
  @plastic_id = options['plastic_id'].to_i
  @tag_id = options['tag_id'].to_i
end

#create new product
def save()
  sql = "INSERT INTO products (name, avoidability, quantity, plastic_id, tag_id) VALUES ($1, $2, $3, $4, $5) RETURNING id"
  values=[@name, @avoidability, @quantity, @plastic_id, @tag_id]
  results= SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end

def update()
  sql = "UPDATE products SET (name, avoidability, quantity, plastic_id, tag_id) = ($1, $2, $3, $4, $5) WHERE id=$6"
  values=[@name, @avoidability, @quantity, @plastic_id, @tag_id, @id]
  SqlRunner.run(sql, values)
end
#find all plastics

#find all tags

#find all products
def self.all()
  sql = "SELECT * FROM products"
  products_data = SqlRunner.run(sql)
  products = products_data.map {|product| Product.new( product)}
  return products
end


#delete all products
def self.delete_all
  sql = "DELETE FROM products"
  SqlRunner.run(sql)
end


end #end of class
