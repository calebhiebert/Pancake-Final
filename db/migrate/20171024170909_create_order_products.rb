class CreateOrderProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :order_products do |t|
      t.belongs_to :order, index: true
      t.belongs_to :product, index: true
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
