# new session route
get '/login' do
  erb :login
end

# create session route
post '/login' do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    @errors = ["Wrong username or password"]
    erb :login
  end
end

# delete session route
get '/logout' do
  session.clear
  redirect '/'
end
