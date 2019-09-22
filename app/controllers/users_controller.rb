class UsersController < ApplicationController

get '/signup' do
  erb :'user/signup'
end

post '/signup' do
  @user = User.new(params)

  if @user.save
    session[:user_id] = @user.id
    redirect to :"user/#{@user.slug}"
  else
    redirect to :'user/signup'
  end
end

get '/login' do
  if logged_in?
    @user = User.find_by(session[:user_id])
    redirect to :"user/#{@user.slug}"
  else
    erb :'user/login'
  end
end

post '/login' do
  @user = User.find_by(name: params[:name])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to :"user/#{@user.slug}"
  else
    redirect to :"/login"
  end
end

post '/user/post' do
  if params[:add_to_favorites?] == "on"
    @favorite = Favorite.find_or_create_by(:user_id => current_user.id, :work_id => params[:work_id])
    binding.pry
  #   if
  #   @favorite_item = FavoritedWork.create(:work_id => params[:work_id], :favorite_id => current_user.favorites)
  # @user.
  end
end

get '/user/:slug' do
  @user = User.find_by_slug(params[:slug])
  erb :'user/profile'
end

get '/logout' do
  if logged_in?
    session.clear
    redirect "/login"
  else
    redirect '/'
  end
end

end
