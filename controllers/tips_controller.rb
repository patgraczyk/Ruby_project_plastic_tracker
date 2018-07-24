#
get '/tips' do
  @tips = Tip.all()
  erb (:"tips/index")
end
