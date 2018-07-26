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
  @products_quantity = Product.quantity_sum
  @products_weight = Product.weight_sum
  @products_emissions = Product.carbon_emissions
  @filtered = false
  erb( :"products/index")
end

#get products by tag id
get '/products/tag/:id' do
  tag_id = params[:id]
  @products = Product.products_by_tag(tag_id)
  @tags = Tag.all()
  @plastics = Plastic.all()
  @products_quantity = Product.quantity_sum
  @products_weight = Product.weight_sum
  @products_emissions = Product.carbon_emissions
  @filtered = true
  erb( :"products/index")
end

#get products by plastic id
get '/products/plastic/:id' do
  plastic_id = params[:id]
  @products = Product.products_by_plastic(plastic_id)
  @tags = Tag.all()
  @plastics = Plastic.all()
  @products_quantity = Product.quantity_sum
  @products_weight = Product.weight_sum
  @products_emissions = Product.carbon_emissions
  @filtered = true
  erb( :"products/index")
end

get '/products/month/:month' do
  selected_month = params[:month]
  @products = Product.by_month(selected_month)
  @tags = Tag.all()
  @plastics = Plastic.all()
  @products_quantity = Product.quantity_sum
  @products_weight = Product.weight_sum
  @products_emissions = Product.carbon_emissions
  @filtered = true
  erb( :"products/index")
end

get '/products/impact' do
  @products = Product.all()
  @tags = Tag.all()
  @plastics = Plastic.all()
  @products_quantity = Product.quantity_sum
  @products_weight = Product.weight_sum
  @products_emissions = Product.carbon_emissions
  @products_avoidable = Product.avoidable(true)
  @products_recycable = Product.recycable(true)
  @products_top_tag = Product.most_common_tag
  @products_top_plastic = Product.most_common_plastic
  erb (:"products/impact")
end

get '/products/plastic' do
  @products = Product.all()
  @tags = Tag.all()
  @plastics = Plastic.all()
  @products_quantity = Product.quantity_sum
  @products_weight = Product.weight_sum
  @products_emissions = Product.carbon_emissions
  erb( :"products/plastic" )
end

get '/products/plastic/:id' do
  plastic_id = params[:id]
  @products = Product.products_by_plastic(plastic_id)
  @tags = Tag.all()
  @plastics = Plastic.all()
  @products_quantity = Product.quantity_sum
  @products_weight = Product.weight_sum
  @products_emissions = Product.carbon_emissions
  erb( :"products/index")
end


#create a new product
get '/products/new' do
  @tags = Tag.all()
  @plastics = Plastic.all()
  erb(:"products/new")
end

#save a new product to the list
post '/products' do
  @product = Product.new(params)
  @product.save
  erb(:"products/create")
end

#show a specific product by id
get '/products/:id' do
  @product= Product.find(params['id'])
  erb(:"products/show")
end

#edit the selected product
get '/products/:id/edit' do
  @tags = Tag.all()
  @plastics = Plastic.all()
  @product = Product.find(params['id'])
  erb(:"products/edit")
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
