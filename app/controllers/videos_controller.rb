class VideosController < ApplicationController
  before_action :authenticate_user!,only: [:edit,:update,:new,:create]
  append_before_action :user_authen,only: [:edit,:update]
  impressionist :action => [:show],:unique => [:session_hash]

  def index
    @videos = Video.order(created_at: "desc").limit(8)
    @most_viewed_videos = Video.order(impressions_count: "desc").limit(8)
    @most_liked_videos = Video.order(cached_votes_up: "desc").limit(8)
    respond_to do |format|
      format.html
    end
  end

  def recent
    @videos = Video.order(created_at: "desc").paginate(:page => params[:page],per_page: APP_CONFIG['per_page'])
  end

  def hot
    @videos = Video.order(cached_votes_up: "desc").paginate(:page => params[:page],per_page: APP_CONFIG['per_page'])
  end

  def show
    @video = Video.find(params[:id])
    @related_videos = @video.related_videos
    @comment = @video.comments.recent
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

  def search
    @videos = Video.where("name LIKE ?","%#{params[:query]}%")
  end


  private

  def permitted_params
    params.require(:video).permit(:artist,:description,:name,:local_remote_url,:youtube_remote_url,:category_id,:stages_attributes => [:id,:name,:start_at,:end_at])
  end

  def user_authen
    video = Video.find(params[:id])
    if current_user.id != video.owner.id
      redirect_to root_path
    end
  end

end

