require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "henle_verlag_urtext"
  end

  get '/' do
    erb :index
  end

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

  get '/test' do
    erb :'templates/code_cuttings'
  end


  helpers do
      def current_user
        @current_user ||= User.find_by(id: session[:user_id])
      end

      def logged_in?
        !!current_user
      end

    end


end
