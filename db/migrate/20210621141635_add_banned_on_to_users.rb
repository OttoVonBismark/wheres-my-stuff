class AddBannedOnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :banned_on, :date
  end
end
