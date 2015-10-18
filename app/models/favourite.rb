class Favourite < ActiveRecord::Base
  belongs_to :user,:dependent => :destroy
  belongs_to :video,-> {where(type: "video")}, :foreign_key => :target_id
  belongs_to :course,-> {where(type: "course")}, :foreign_key => :target_id
end
