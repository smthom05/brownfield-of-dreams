# migration to create Tutorials class
class CreateTutorials < ActiveRecord::Migration[5.2]
  # frozen_string_literal: true
  def change
    create_table :tutorials do |t|
      t.string :title
      t.text :description
      t.string :thumbnail
      t.string :playlist_id
      t.boolean :classroom, default: false

      t.timestamps
    end
  end
end
