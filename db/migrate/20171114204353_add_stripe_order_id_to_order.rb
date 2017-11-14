class AddStripeOrderIdToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :stripe_charge_id, :string
  end
end
