class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :users, index: true
      t.string :status
      t.decimal :pst
      t.decimal :gst
      t.decimal :hst

      t.timestamps
    end
  end
end
