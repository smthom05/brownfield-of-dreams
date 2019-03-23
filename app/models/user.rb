class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :users, foreign_key: :user_id,
                   class_name: 'Friend',
                   dependent: :destroy

  has_many :friends, foreign_key: :friend_id,
                     class_name: 'Friend',
                     dependent: :destroy

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  validates_uniqueness_of :uid, allow_nil: true

  enum role: [:default, :admin]
  has_secure_password

  def self.find_token(user_id)
    where(id: user_id).pluck(:token)[0]
  end
end
