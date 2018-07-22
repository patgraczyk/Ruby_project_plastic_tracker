require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/tags_controller')
require_relative('controllers/plastics_controller')
require_relative('controllers/products_controller')

# get '/' do
#   erb( :index )
# end
get '/index' do
  "Hello World"
end
