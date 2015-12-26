class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      format.html {
        if @user.update(permitted_params)
          redirect_to edit_user_path @user,:flash => {:success => "Update successfully"}
        else
          flash[:error] = "Update failed"
          render 'edit'
        end
      }
      format.js
    end


  end

  def follow
    respond_to do |format|
      format.js {
        @res = current_user.follow params[:follow_id]
      }
      format.html
    end
  end

  def unfollow
    respond_to do |format|
      format.js {
        @res = current_user.unfollow params[:follow_id]
      }
      format.html
    end
  end

  def videos
    @user = User.find(params[:id])
    @videos = @user.videos.paginate(:page => params[:page],per_page: APP_CONFIG['per_page'])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def permitted_params
    params.require(:user).permit(:username,:email,:password,:password_confirmation)
  end


end
