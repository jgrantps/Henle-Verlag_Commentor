require 'rack-flash'
class UsersController < ApplicationController
use Rack::Flash


get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(params)

  if @user.save
      session[:user_id] = @user.id
      redirect to 'users/profile'
    else
      redirect to 'users/signup'
    end
end

get '/login' do
  if logged_in?
      redirect to 'users/profile'
    else
      erb :'users/login'
    end
end

post '/login' do
  @user = User.find_by(username: params[:username])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect 'users/profile'
  else
    redirect "/login"
  end
end




  get '/select' do
    erb :'user/select'
  end

  post '/select' do

    @initial = Initial.find_or_create_by(initial: params[:composer_initial].upcase, url:"https://www.henle.de/us/search/?Composers=#{params[:composer_initial].upcase}")
binding.pry
    if !!@initial
      flash[:message] = "Successfully filed the initial."
      redirect to ("/composer/#{@initial.initial}")
    else
    redirect :'/select'
  end
  end
end
