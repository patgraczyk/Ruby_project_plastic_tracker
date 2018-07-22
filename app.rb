require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/tags_controller')
require_relative('controllers/plastics_controller')
require_relative('controllers/products_controller')
also_reload('./models/*')


get '/' do
  erb( :index )
end
