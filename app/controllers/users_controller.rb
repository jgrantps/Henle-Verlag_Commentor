class UsersController < ApplicationController

  get '/select' do
    erb :'user/select'
  end

  post '/select' do
    Alphabetized.new(params[:composer_initial])
    erb :'composer'
  end
end
