class CommentsController < ApplicationController

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


end
