class ComposersController < ApplicationController

get '/select' do
  erb :'composer/select'
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
