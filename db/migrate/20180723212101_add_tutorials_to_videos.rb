class AddTutorialsToVideos < ActiveRecord::Migration[5.2]
  def change
    add_reference :videos, :tutorial, index: true
  end
end
