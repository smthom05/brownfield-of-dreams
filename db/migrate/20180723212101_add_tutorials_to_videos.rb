# migration to add reference to Tutorials in Videos
class AddTutorialsToVideos < ActiveRecord::Migration[5.2]
  # frozen_string_literal: true
  def change
    add_reference :videos, :tutorial, index: true
  end
end
