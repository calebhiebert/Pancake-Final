class CreateOrderProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :order_products do |t|
      t.belongs_to :orders, index: true
      t.belongs_to :products, index: true
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
