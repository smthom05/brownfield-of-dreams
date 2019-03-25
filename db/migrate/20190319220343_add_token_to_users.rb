# migration to add token column to User class
class AddTokenToUsers < ActiveRecord::Migration[5.2]
  # frozen_string_literal: true
  def change
    add_column :users, :token, :string
  end
end
