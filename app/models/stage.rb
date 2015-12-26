class Stage < ActiveRecord::Base
  belongs_to :video

  validates :name,presence: true
  validates :start_at,presence: true
  validates :end_at,presence: true
end
