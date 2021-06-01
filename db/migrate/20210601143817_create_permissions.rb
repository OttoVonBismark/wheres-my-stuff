class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :allowed

      t.timestamps
    end
  end
end
