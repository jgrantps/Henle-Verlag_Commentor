class CommentsController < ApplicationController

  #=> capture and qualify a posted comment and favorite selection from the user.
  post '/comment/post' do
    @work = Work.find(params[:work_id])
    @composer = @work.composer

    if logged_in?
      #=> capture the favorites checkbox selection and route the appropriate activerecord call.
      if params[:add_to_favorites?] == "on"
        @favorite = Favorite.find_or_create_by(:user_id => current_user.id, :work_id => params[:work_id])
      elsif params[:remove_from_favorites?] == "on"
        @favorite = Favorite.find_by(:user_id => current_user.id, :work_id => params[:work_id])
        @favorite.destroy
      end

      #=> capture the comment and create a new comment.
      if !(params[:comments].empty?)
        @comment = Comment.find_or_create_by(:content => params[:comments], :user_id => current_user.id, :work_id => params[:work_id])
      end

      #=> display results.
      redirect to "/user/#{@current_user.slug}"
    end
  end

  #=> instantiate a selected comment and route to edit page.
  post '/comment/edit' do
    @comment=Comment.find(params[:comment_id])

    if @comment.user == current_user
      @work = Work.find(@comment.work_id)
      erb :"comment/edit"
    else
      #!!!!!!INSERT A FLASH ERROR MESSAGE!!!!!!!!
      redirect to "/user/#{@current_user.slug}"
    end
  end

  #=> capture the edit and update comment.
  patch '/comment/edit' do
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

  #=> delete comment.
  delete '/comment/edit' do
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


end
