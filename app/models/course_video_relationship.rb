class CourseVideoRelationship < ActiveRecord::Base
  has_many :courses
  has_many :videos
end
