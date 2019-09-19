require 'rack-flash'
class ComposersController < ApplicationController
use Rack::Flash

  get '/composer/:id' do
    @initial = Initial.find_by(:initial => params[:id])
    binding.pry
      erb :'/composer/byinitial'
  end

  get '/composer/feature/:slug' do
    @composer = Composer.find_by_slug(params[:slug])
    # @works = Work.find_or_create_by()
    erb :'/composer/composer'
  end
end
