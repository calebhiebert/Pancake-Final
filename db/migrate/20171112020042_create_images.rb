class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.belongs_to :product, index: true
      t.string :ext
      t.string :ident

      t.timestamps
    end
  end
end
