class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.belongs_to :users
      t.has_one :province
      t.string :address
      t.string :postal_code
      t.timestamps
    end
  end
end
