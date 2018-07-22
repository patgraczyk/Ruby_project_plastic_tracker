require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/tag.rb' )
also_reload('./models/*')

get '/tags' do
  @tags = Tag.all()
  erb ( :"tags/index" )
end

#create a new tag
get '/tags/new' do
  @tags = Tag.all()
  erb( :"tags/new" )
end

#post a new tag
post '/tags' do
  @tag = Tag.new(params)
  @tag.save
  erb( :"tags/create" )
end

#show the tag

get '/tags/:id' do
  @tag = Tag.find(params['id'])
  erb(:"tags/show")
end

# edit the tag
get '/tags/:id/edit' do
  @tag = Tag.find(params['id'])
  erb(:"tags/edit")
end
#
# #update tag and post it
# post '/tags/:id' do
#   tag = Tag.new(params)
#   tag.update
#   redirect to "tags/#{params['id']}"
# end
#delete tag
