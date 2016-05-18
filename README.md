# sinatra-skeleton-with-users

Create a CRUD app
add gems:
	gem ‘pry’
gem ‘bcrypt’

bundle install
	-create migrations here
be rake db:create
be rake db:migrate
be rake db:seed


Migrations:
be rake generate:migration NAME=create_user
be rake generate:model NAME=user

MIGRATIONS
User migration

class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username, null: false, unique: true
  		t.string :email, null: false, unique: true
  		t.string :password_digest, null: false

  		t.timestamps(null: false)
  	end
  end
end


MODELS
User model

class User < ActiveRecord::Base
  has_secure_password

  validates :username, :email, :password, presence: true
  validates :email, uniqueness:true
end


CONTROLLERS
User controller
	
get '/users/new' do 
	erb :'users/new'
end

post '/users' do
	user = User.new(params[:user])
	if user.save
		session[:user_id] = user.id
		redirect '/users/user.id'
	else
		@errors = @user.errors.full_messages
		erb :"/users/new"
	end
end

get '/users/:id' do
	@user = User.find_by(id: params[:id])
	#if current_user && logged_in?
		erb :'/users/show'
	#else
	#	redirect '/'
	#end
end

Session controller

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


HELPERS
 Session
helpers do
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
end

VIEWS

Users/new.erb

<h1>New user form<h1>

<% if @errors %>
  <span>Something went wrong:</span>
  <ul class="error-list pad-b-2">
    <% @errors.each do |error| %>
      <li class="error-item"><%= error %></li>
    <% end %>
  </ul>
<% end %>

<form action='/users' method='Post'>
  <input type='text' name='user[username]' placeholder='Username'><br>
  <input type='text' name='user[email]' placeholder='Email Address'><br>
  <input type='password' name='user[password]' placeholder='Password'><br>
  <input type='submit' value='Register' class=”button”>
</form>

Login

<% if @errors %>
  <ul>
    <% @errors.each do |message| %>
      <li><%= message %></li>
    <% end %>
  </ul>
<% end %>

<form method="post" action="/login">
  Username:
  <input id="username-input" name="username" placeholder="Username" type="text" >

  Password:
  <input id="password-input" name="password" type="password" placeholder="Password" >

<input type="submit" value="Log in">
</form>

LAYOUT

<!DOCTYPE html>
<html lang="en">
<head>
  <link rel="stylesheet" href="/css/normalize.css?app=skills">
  <link rel="stylesheet" href="/css/application.css?app=skills">

  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script src="/js/application.js?app=skills"></script>

  <title></title>
</head>
<body>
 <ul>
    <% if logged_in? %>
      <li>Welcome to the site, <%= current_user.first_name %></li>
      <li><a href="/users/<%=current_user.id%>">Profile</a></li>
      <li><a href="/logout">Logout</a></li>
    <% else %>
      <li>Subscriptions</li>
      <li><a href="/users/new">Sign up</a></li>
      <li><a href="/login">Login</a></li>
    <% end %>
      <li><a href="/">home</a></li>
  </ul>

  <%= yield %>
</body>
</html>
