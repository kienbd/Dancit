class VideosController < ApplicationController
  impressionist :action => [:show],:unique => [:session_hash]

  def index
    @videos = Video.all.order(created_at: "desc")
    respond_to do |format|
      format.html
    end
  end

  def show
    @video = Video.find(params[:id])
    impressionist(@video)
  end

  def new
    @video = Video.new
    respond_to do |format|
      format.html

    end
  end

  def create
    @video = current_user.videos.new(permitted_params)
    binding.pry
    respond_to do |format|
      format.html {
        if @video.save
          redirect_to edit_video_path @video
        else
          render 'new'
        end
      }
    end
  end


  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    @res = @video.update_attributes(permitted_params)
    respond_to do |format|
      format.html {
        if @res
          redirect_to @video
        else
          render 'edit'
        end
      }
      format.js
    end
  end


  private

  def permitted_params
    params.require(:video).permit(:artist,:description,:name,:local_remote_url,:youtube_remote_url,:stages_attributes => [:name,:start_at,:end_at])
  end

end

