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

  get '/test' do
    erb :test
  end

  helpers do
      # def signup_form_incomplete?(params)
      #   (params[:name].empty? || params[:email].empty? || params[:password].empty?)
      # end

      def current_user
        @current_user ||= User.find_by(id: session[:user_id])
      end

      def logged_in?
        !!current_user
      end

    end


end
