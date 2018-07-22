require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/plastic.rb' )

get '/plastics' do
  @plastics = Plastic.all()
  erb ( :"plastics/index" )
end

#create new
get '/plastics/new' do
  @plastics = Plastic.all()
  erb (:"plastics/new")
end
