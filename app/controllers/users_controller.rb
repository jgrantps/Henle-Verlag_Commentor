class UsersController < ApplicationController

  get '/select' do
    erb :'select'
  end

  post '/select' do
    binding.pry
    erb :'composer'
  end
