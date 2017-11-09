class AddProvinceNameToProvinces < ActiveRecord::Migration[5.1]
  def change
    add_column :provinces, :name, :string
  end
end
