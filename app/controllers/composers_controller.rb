require 'rack-flash'
class ComposersController < ApplicationController
use Rack::Flash

  get '/composer/:id' do
    @initial = Initial.find_by(:initial => params[:id])
      erb :'/composer/byinitial'
  end

  get '/composer/feature/:slug' do
    @composer = Composer.find_by_slug(params[:slug])

    if @composer.works.empty?
      @composer.scrape_page
    end

    erb :'/composer/composer'
  end
end
