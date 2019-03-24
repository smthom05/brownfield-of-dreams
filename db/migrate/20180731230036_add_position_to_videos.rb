class AddPositionToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :position, :integer, default: 0
  end
end
