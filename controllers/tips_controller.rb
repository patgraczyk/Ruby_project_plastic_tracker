require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/tip.rb' )

get '/tips' do
  @tips = Tip.all()
  erb (:"tips/index")
end
