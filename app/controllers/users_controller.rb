class UsersController < ApplicationController

  get '/select' do
    erb :'user/select'
  end

  post '/select' do
    binding.pry

    iii = Alphabetized.new(params[:composer_initial])
    binding.pry
    erb :'composer'
  end
end
