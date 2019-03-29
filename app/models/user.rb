class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :user_friendships, foreign_key: :user_id,
                              class_name: 'Friend',
                              dependent: :destroy

  has_many :users, through: :user_friendships

  has_many :friendships, foreign_key: :friend_id,
                         class_name: 'Friend',
                         dependent: :destroy

  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  validates_uniqueness_of :uid, allow_nil: true

  enum role: [:default, :admin]
  has_secure_password

  def self.find_token(user_id)
    where(id: user_id).pluck(:token)[0]
  end

  def not_friended?(github_id)
    friend = User.joins('JOIN friends ON users.id = friends.friend_id')
                 .where(friends: { user_id: id })
                 .find_by(uid: github_id)

    friend.class == NilClass
  end

  def bookmarks
    Video.select('videos.title video,
                 tutorials.title tutorial_title,
                 users.id uid,
                 tutorials.id tutorial_id,
                 user_videos.user_id,
                 user_videos.video_id')
         .joins(:tutorial, :users)
         .where(users: { id: id })
         .order('tutorial_id')
  end
end
