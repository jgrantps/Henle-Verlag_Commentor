class UsersController < ApplicationController

  post '/user/post' do
    binding.pry
    @work = Work.find(params[:work_id])
    @composer = @work.composer
    binding.pry

    if params[:add_to_favorites?] == "on"
      @favorite = Favorite.find_or_create_by(:user_id => current_user.id, :work_id => params[:work_id])
    elsif params[:remove_from_favorites?] == "on"
      @favorite = Favorite.find_by(:user_id => current_user.id, :work_id => params[:work_id])
      @favorite.destroy
    end

    if !(params[:comments].empty?)
      @comment = Comment.find_or_create_by(:content => params[:comments], :user_id => current_user.id, :work_id => params[:work_id])
    end
  binding.pry
    redirect to "/composer/feature/#{@composer.slug}"
  end



  get '/user/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'user/profile'
  end

end
