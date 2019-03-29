class Friend < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :friend, class_name: 'User'

  validates_presence_of :user_id
  validates_presence_of :friend_id
end
