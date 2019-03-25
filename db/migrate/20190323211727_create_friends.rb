# migration to create Friends self refential table for User class
class CreateFriends < ActiveRecord::Migration[5.2]
  # frozen_string_literal: true
  def change
    create_table :friends do |t|
      t.references :user, foreign_key: { to_table: :users }
      t.references :friend, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
