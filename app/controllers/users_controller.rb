class UsersController < ApplicationController

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

  patch '/user/edit' do
    @comment=Comment.find(params[:comment_id])
    binding.pry
    if @comment.user_id == current_user.id
      @work = Work.find(@comment.work_id)
      erb :"user/edit"
    else
      redirect to "/user/#{@current_user.slug}"
    end
  end

  get '/user/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'user/profile'
  end

end
