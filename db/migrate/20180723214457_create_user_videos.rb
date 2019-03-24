# migration to create UserVideos joins table class
class CreateUserVideos < ActiveRecord::Migration[5.2]
  # frozen_string_literal: true
  def change
    create_table :user_videos do |t|
      t.references :user, foreign_key: true
      t.references :video, foreign_key: true
      t.timestamps
    end
  end
end
