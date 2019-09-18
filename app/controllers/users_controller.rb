require 'rack-flash'
class UsersController < ApplicationController
use Rack::Flash

  get '/select' do
    erb :'user/select'
  end

  post '/select' do
    @initial = Initial.find_or_create_by(initial: params[:composer_initial].upcase, url:"https://www.henle.de/us/search/?Composers=#{params[:composer_initial].upcase}")

    if !!@initial
      flash[:message] = "Successfully filed the initial."
      redirect to ("/composer/#{@initial.initial}")
    else
    redirect :'/select'
  end
  end
end
