class Video < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :video_id
  validates_presence_of :position

  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
end
