# migration to add positon column to Video class
class AddPositionToVideos < ActiveRecord::Migration[5.2]
  # frozen_string_literal: true
  def change
    add_column :videos, :position, :integer, default: 0
  end
end
