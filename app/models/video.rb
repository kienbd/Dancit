class Video < ActiveRecord::Base

  #Relationships
  belongs_to :owner, :foreign_key => :user_id,:class_name => User
  has_many :course_video_relationships
  has_many :courses, :through => :course_video_relationships
  has_many :stages
  belongs_to :category
  accepts_nested_attributes_for :stages,allow_destroy: true

  mount_uploader :local_remote_url, LocalVideoUploader

  validates :name,presence:  true
  validates :category_id,presence: true

  #view count
  is_impressionable :counter_cache => true

  #like
  acts_as_votable

  #comment
  acts_as_commentable

  #youtube thumbnail
  after_save :get_thumbnail


  def get_thumbnail
    if self.thumbnail.nil?
      if !self.youtube_remote_url.nil? && !self.youtube_remote_url.empty?
        video_info = VideoInfo.new(self.youtube_remote_url)
        self.thumbnail = video_info.thumbnail_medium elsif !self.local_remote_url.nil?
        self.thumbnail = self.local_remote_url.thumb.url
      end
      self.save
    end
  end

  def thumb
    self.thumbnail||"assets/assets/video-thumbnail.png"
  end

  def related_videos
    own_videos = Video.where(user_id: self.user_id)
    if own_videos.length < 5
      own_videos.concat Video.where(category_id: self.category_id)
    end
    own_videos
  end

  def source_link
    if !self.youtube_remote_url.nil?
      return self.youtube_remote_url
    elsif !self.s3_remote_url.nil?
      return self.s3_remote_url
    elsif !self.local_remote_url.nil?
      return self.local_remote_url
    end
  end

	def from_youtube?
		return !self.youtube_remote_url.nil? && !self.youtube_remote_url.empty?
	end

	def from_local?
		return !self.local_remote_url.nil?
	end

  def view_count
    self.impressionist_count(:filter=>:ip_address)
  end

  def like_count
    self.get_likes.size
  end

end
