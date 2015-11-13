class VideosController < ApplicationController
  impressionist :action => [:show],:unique => [:session_hash]

  def index

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
    @video = Video.new(permitted_params)
    respond_to do |format|
      format.html {
        if @video.save
          redirect_to @video
        end
      }
    end

  end


  def edit
    @video = Video.find(params[:id])
  end


  private

  def permitted_params
    params.require(:video).permit(:artist,:description,:name,:local_remote_url,:stages_attributes => [:name,:start_at,:end_at])
  end

end

