class UsersController < ApplicationController

  get '/signup' do
    redirect to :"/"
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to :"user/#{@user.slug}"
    else
      redirect to :'/'
    end
  end

  post '/user/post' do

    @work = Work.find(params[:work_id])
    @composer = @work.composer

    if params[:add_to_favorites?] == "on"
      @favorite = Favorite.find_or_create_by(:user_id => current_user.id, :work_id => params[:work_id])
    elsif params[:remove_from_favorites?] == "on"
      @favorite = Favorite.find_by(:user_id => current_user.id, :work_id => params[:work_id])
      @favorite.destroy
    end

    if !(params[:comments].empty?)
      @comment = Comment.find_or_create_by(:content => params[:comments], :user_id => current_user.id, :work_id => params[:work_id])
    end

    redirect to "/user/#{@current_user.slug}"
  end







  get '/user/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'user/profile'
  end

end
