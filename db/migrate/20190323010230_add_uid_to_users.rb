# migration to add uid column to User class
class AddUidToUsers < ActiveRecord::Migration[5.2]
  # frozen_string_literal: true
  def change
    add_column :users, :uid, :bigint
  end
end
