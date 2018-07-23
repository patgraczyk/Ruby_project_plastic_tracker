require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/product.rb' )
require_relative( '../models/plastic.rb' )
require_relative( '../models/tag.rb' )
require( 'pry-byebug' )

#index of all products
get '/products' do
  @products = Product.all()
  @tags = Tag.all()
  @plastics = Plastic.all()
  @product = Product.quantity_sum
  erb ( :"products/index" )
end

#create a new product
get '/products/new' do
  @tags = Tag.all()
  @plastics = Plastic.all()
  erb (:"products/new")
end

#save a new product to the list
post '/products' do
  @product = Product.new(params)
  @product.save
  erb (:"products/create")
end

#show a specific product by id
get '/products/:id' do
  @product= Product.find(params['id'])
  erb (:"products/show")
end

#edit the selected product
get '/products/:id/edit' do
  @tags = Tag.all()
  @plastics = Plastic.all()
  @product = Product.find(params['id'])
  erb (:"products/edit")
end

#post the edited form
post '/products/:id' do
  product=Product.new(params)
  product.update
  redirect to "products/#{params['id']}"
end

#delete product
post '/products/:id/delete' do
  @product = Product.find(params['id'])
  @product.delete
  redirect to "products"
end
