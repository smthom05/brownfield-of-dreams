class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.references :user, foreign_key: { to_table: :users }
      t.references :friend, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
