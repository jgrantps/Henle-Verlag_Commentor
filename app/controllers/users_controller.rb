class UsersController < ApplicationController

  get '/select' do
    erb :'user/select'
  end

  post '/select' do
    binding.pry
    erb :'composer'
  end
end
