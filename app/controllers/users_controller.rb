class UsersController < ApplicationController

  get '/select' do
    erb :'user/select'
  end

  post '/select' do
    binding.pry

    iii = Alphabetized.create(initial: params[:composer_initial])
    erb :'composer'
  end
end
