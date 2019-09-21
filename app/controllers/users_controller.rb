require 'rack-flash'
class UsersController < ApplicationController
use Rack::Flash


get '/signup' do
  erb :'user/signup'
end

post '/signup' do
  @user = User.new(params)
  binding.pry

  if @user.save
    binding.pry

    session[:user_id] = @user.id
    redirect to :'user/#{@user.slug}'
  else
    redirect to :'user/signup'
  end
end

get '/login' do
  if logged_in?
    @user = User.find_by(session[:user_id])
    redirect to :"user/#{@user.slug}"
  else
    erb :'user/login'
  end
end

post '/login' do
  @user = User.find_by(name: params[:name])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to :"user/#{@user.slug}"
  else
    redirect to :"/login"
  end
end

get '/user/:slug' do
  @user = User.find_by_slug(params[:slug])
  binding.pry
  erb :'user/profile'
end




  get '/logout' do
    if logged_in?
       session.clear
       redirect "/login"
     else
       redirect '/'
     end
  end
end
