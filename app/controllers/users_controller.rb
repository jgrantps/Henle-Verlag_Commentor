class UsersController < ApplicationController

  get '/signup' do
    redirect to :"/"
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to :"user/#{@user.slug}"
    else
      redirect to :'/'
    end
  end

  get '/login' do
    if logged_in?
      @user = User.find_by(session[:user_id])
      redirect to :"user/#{@user.slug}"
    else
      redirect to :"/"
    end
  end

  post '/login' do
    @user = User.find_by(name: params[:name])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to :"user/#{@user.slug}"
    else
      redirect to :"/"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/"
    else
      redirect '/'
    end
  end

  get '/user/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'user/profile'
  end

end
