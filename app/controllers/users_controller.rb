require 'rack-flash'
class UsersController < ApplicationController
use Rack::Flash

  get '/select' do
    erb :'user/select'
  end

  post '/select' do
    # binding.pry

    @initial = Initial.find_or_create_by(initial: params[:composer_initial].upcase, url:"https://www.henle.de/us/search/?Composers=#{params[:composer_initial].upcase}")
    binding.pry


    flash[:message] = "Successfully filed the initial."
    # binding.pry
    erb :'composer'
  end
end
