class AddPriceToThings < ActiveRecord::Migration[6.1]
  def change
    add_column :things, :price, :decimal, precision: 8, scale: 2, default: 0.00
  end
end
