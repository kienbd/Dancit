class LikesController < ApplicationController

  def create
    if params[:video_id]
      resource = Video.find(params[:video_id])
    elsif params[:course_id]
      resource = Course.find(params[:course_id])
    end
    resource.liked_by current_user
    respond_to do |format|
      format.html {
      }
      format.js
    end
  end

end
