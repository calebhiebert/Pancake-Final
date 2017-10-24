class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :stock_quantity
      t.decimal :price
      t.string :image
      t.string :categroy

      t.timestamps
    end
  end
end
