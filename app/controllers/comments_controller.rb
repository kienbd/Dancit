class CommentsController < ApplicationController

  def create
    if params[:video_id]
      resource = Video.find(params[:video_id])
    elsif params[:course_id]
      resource = Course.find(params[:course_id])
    end
    @comment = resource.comments.create(title: current_user.username,user_id: current_user.id,comment: params[:comment])
    @comment.save
    respond_to do |format|
      format.html
      format.js
    end

  end

  def show

  end

  def index

  end

end
