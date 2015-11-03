class VideosController < ApplicationController


  def index

  end


  def show
    @video = Video.find(params[:id])

  end

  def new
    @video = Video.new
    respond_to do |format|
      format.html

    end
  end

  def create
    @video = Video.new(permiited_params)
    respond_to do |format|
      format.html {
        if @video.save
          redirect_to @video
        end
      }
    end

  end


  def edit

  end


  private

  def permiited_params
    params.require(:video).permit(:artist,:description,:name,:local_remote_url)

  end


end

