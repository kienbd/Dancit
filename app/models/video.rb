class Video < ActiveRecord::Base

  #Relationships
  belongs_to :owner, :foreign_key => :user_id,:class_name => User
  has_many :course_video_relationships
  has_many :courses, :through => :course_video_relationships
  has_many :stages

  mount_uploader :local_remote_url, LocalVideoUploader

  #view count
  is_impressionable

  #like
  acts_as_votable

  #comment
  acts_as_commentable
end
