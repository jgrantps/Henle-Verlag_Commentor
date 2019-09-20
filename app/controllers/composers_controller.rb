require 'rack-flash'
class ComposersController < ApplicationController
use Rack::Flash

  get '/composer/:id' do
    @initial = Initial.find_by(:initial => params[:id])
      erb :'/composer/byinitial'
  end

  get '/composer/feature/:slug' do
    @composer = Composer.find_by_slug(params[:slug])
    @composer.scrape_page
    erb :'/composer/composer'
  end
end
