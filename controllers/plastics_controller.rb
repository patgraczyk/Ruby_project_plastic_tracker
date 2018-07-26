require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/plastic.rb' )

get '/plastics' do
  @plastics = Plastic.all()
  erb( :"plastics/index" )
end

#create new
get '/plastics/new' do
  @plastics = Plastic.all()
  erb(:"plastics/new")
end

#post a new plastic
post '/plastics' do
  @plastic = Plastic.new(params)
  @plastic.save
  erb( :"plastics/create" )
end

#show the plastic
get '/plastics/:id' do
  @plastic = Plastic.find(params['id'])
  erb(:"plastics/show")
end

#edit the plastic entry
get '/plastics/:id/edit' do
  @plastic = Plastic.find(params['id'])
  erb( :"plastics/edit")
end

#post edited form
post '/plastics/:id' do
  plastic = Plastic.new(params)
  plastic.update
  redirect to "plastics/#{params['id']}"
end

#delete plastic
post '/plastics/:id/delete' do
  @plastic = Plastic.find(params['id'])
  @plastic.delete
  redirect to "plastics"
end
