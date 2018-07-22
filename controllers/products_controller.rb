require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/product.rb' )
require_relative( '../models/plastic.rb' )
require_relative( '../models/tag.rb' )
require( 'pry-byebug' )


get '/products' do
  @products = Product.all()
  erb ( :"products/index" )
end
