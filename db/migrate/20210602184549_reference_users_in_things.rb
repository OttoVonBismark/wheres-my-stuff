class ReferenceUsersInThings < ActiveRecord::Migration[6.1]
  def change
    add_reference :things, :user, foreign_key: true
  end
end
