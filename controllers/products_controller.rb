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
