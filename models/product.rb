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

#update product
def update()
  sql = "UPDATE products SET (name, avoidability, quantity, plastic_id, tag_id) = ($1, $2, $3, $4, $5) WHERE id=$6"
  values=[@name, @avoidability, @quantity, @plastic_id, @tag_id, @id]
  SqlRunner.run(sql, values)
end

#find type of plastic
def plastic()
  sql = "SELECT * FROM plastics WHERE id=$1"
  values=[@plastic_id]
  results= SqlRunner.run(sql, values)
  return Plastic.new( results.first )
end

#find all tags
def tag()
  sql = "SELECT * FROM tags WHERE id=$1"
  values=[@tag_id]
  results= SqlRunner.run(sql, values)
  return Tag.new( results.first )
end
#calculate until when will the product be on the planet
def existence()
  sql = 'SELECT existence FROM plastics WHERE id=$1'
  values=[@plastic_id]
  results= SqlRunner.run(sql, values)
  return (results.first)['existence'].to_i + 2018
  #2018 hard coded at the moment, will change to use as a current year from SQL
end

#calculate total quantity of items
def self.quantity_sum()
  sql = "SELECT SUM(quantity) FROM products"
  results= SqlRunner.run(sql)
  return results.first['sum'].to_i
end

#find all products
def self.all()
  sql = "SELECT * FROM products"
  products_data = SqlRunner.run(sql)
  products = products_data.map {|product| Product.new( product)}
  return products
end

def self.find(id)
  sql= "SELECT * FROM products WHERE id=$1"
  values=[id]
  results = SqlRunner.run(sql, values)
  return Product.new(results.first)
end

#find all products if avoidable
def self.avoidable(avoidability)
  sql = "SELECT * FROM products WHERE avoidability = $1"
  values = [avoidability]
  products_data = SqlRunner.run(sql, values)
  products = products_data.map {|product| Product.new( product)}
  return products
end

#delete by id
def delete()
  sql = "DELETE FROM products WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql,values)
end

#delete all products
def self.delete_all
  sql = "DELETE FROM products"
  SqlRunner.run(sql)
end


end #end of class
