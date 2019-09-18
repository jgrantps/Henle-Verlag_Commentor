class UsersController < ApplicationController

  get '/select' do
    erb :'user/select'
  end

  post '/select' do
    binding.pry

    iii = ComposerInitial.find_or_create_by(initial: params[:composer_initial])
    binding.pry
    erb :'composer'
  end
end
