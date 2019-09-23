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




  post '/user/edit' do
    @comment=Comment.find(params[:comment_id])
    # binding.pry
    if @comment.user == current_user
      @work = Work.find(@comment.work_id)
      erb :"user/edit"
    else
      #!!!!!!INSERT A FLASH ERROR MESSAGE!!!!!!!!
      redirect to "/user/#{@current_user.slug}"
    end
  end

  patch '/user/edit' do
     binding.pry
    if logged_in?
      @comment=Comment.find(params[:comment_id])
        if @comment.user == current_user && !params[:comment].empty?
          @comment.update(content: params[:comment])
          redirect to :"/user/#{current_user.slug}"
        elsif logged_in? && params[:comment].empty?
          redirect to :"/user/#{current_user.slug}"
        else
          redirect to :"/"
        end
      end
  end


  delete '/user/edit' do
    binding.pry
    @comment = Comment.find(params[:comment_id])
    if @comment.user == current_user
        @comment.delete
        redirect to :"/user/#{current_user.slug}"

    elsif logged_in?
      redirect to :"/user/#{current_user.slug}"
    else
    redirect to :"/"
    end
  end


  get '/user/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'user/profile'
  end

end
