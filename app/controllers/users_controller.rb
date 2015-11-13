class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def edit

  end

  def update

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


end
