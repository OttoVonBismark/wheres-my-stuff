class CreateThings < ActiveRecord::Migration[6.1]
  def change
    create_table :things do |t|
      t.string :name, null: false
      t.text :description
      t.date :ordered_on, null: false
      t.date :shipped_on
      t.string :tracking_number
      t.date :due_on
      t.date :arrived_on

      t.timestamps
    end
  end
end
