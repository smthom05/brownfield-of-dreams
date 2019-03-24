# migration to create Videos class
class CreateVideos < ActiveRecord::Migration[5.2]
  # frozen_string_literal: true
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :video_id
      t.string :thumbnail
    end
  end
end
