require_relative( '../db/sql_runner' )
# require_relative( 'time' )

class Product

  attr_reader( :plastic_id, :tag_id, :id, :time_stamp )
  attr_accessor( :name, :avoidability, :quantity )

def initialize( options )
  @id = options['id'].to_i
  @name = options['name']
  @avoidability= options['avoidability']
  @quantity = options['quantity'].to_i
  @time_stamp = Date.parse(options['time_stamp'])
  @plastic_id = options['plastic_id'].to_i
  @tag_id = options['tag_id'].to_i
end

#create new product
def save()
  sql = "INSERT INTO products (name, avoidability, quantity, time_stamp, plastic_id, tag_id) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id"
  values=[@name, @avoidability, @quantity, @time_stamp, @plastic_id, @tag_id]
  results= SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end

#display carbon emissions per product
def carbon_emissions_per_product()
  sql = 'SELECT (conversion_factor * weight) AS converted FROM plastics INNER JOIN products ON products.plastic_id = plastics.id WHERE products.id = $1'
  values=[@id]
  results= SqlRunner.run(sql, values)
  emission_of_product = results.first['converted'].to_f * @quantity
  return emission_of_product
end

#carbon emissions of all products - to be fixed
def self.carbon_emissions()
  sql = 'SELECT SUM(conversion_factor * weight) AS converted FROM plastics INNER JOIN products ON products.plastic_id = plastics.id '
  results=SqlRunner.run(sql)
  emission_of_products = (results.first['converted'].to_f)
  return emission_of_products
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

# #find all tags
def tag()
  sql = "SELECT * FROM tags WHERE id=$1"
  values=[@tag_id]
  results= SqlRunner.run(sql, values)
  return Tag.new( results.first )
end

#display products by tags
def self.products_by_tag(tag_id)
  sql = "SELECT * FROM products WHERE tag_id=$1"
  values = [tag_id]
  products_data = SqlRunner.run(sql, values)
  return products_data.map {|product| Product.new(product)}
end

#display products by plastic
def self.products_by_plastic(plastic_id)
  sql = "SELECT * FROM products WHERE plastic_id=$1"
  values = [plastic_id]
  products_data = SqlRunner.run(sql, values)
  return products_data.map {|product| Product.new(product)}
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

#calculate total weight of created products
def self.weight_sum()
  sql = "SELECT SUM(weight) FROM plastics INNER JOIN products ON products.plastic_id = plastic_id"
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

#find most popular tag
def self.most_common_tag()
  sql="SELECT tag_id, COUNT(tag_id) AS most_common_tag FROM products
  GROUP BY tag_id ORDER BY most_common_tag DESC LIMIT 1;"
  most_popular_id =SqlRunner.run(sql).first['tag_id'].to_i
  return Tag.find(most_popular_id).category
end

#find most popular plastic
def self.most_common_plastic()
  sql='SELECT plastic_id, COUNT(plastic_id) AS most_common_plastic FROM products
  GROUP BY plastic_id ORDER BY most_common_plastic DESC LIMIT 1;'
  most_popular_id = SqlRunner.run(sql).first['plastic_id'].to_i
  return Plastic.find(most_popular_id).type
end

#edit this to make work
def self.by_month(month_chosen)
  all_products = Product.all
  products_that_month = []
  month = Date.parse.mon(product.bought_on)
  for product in all_products
    if month == month_chosen
      products_that_month.push(product)
    end
  end
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

#find all products if recycable
def self.recycable(recycable)
  sql = "SELECT * FROM plastics INNER JOIN products ON products.plastic_id = plastic_id WHERE recycable = $1"
  values = [recycable]
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
