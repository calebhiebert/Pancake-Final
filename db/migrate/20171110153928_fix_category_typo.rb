class FixCategoryTypo < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :categroy, :category
  end
end
