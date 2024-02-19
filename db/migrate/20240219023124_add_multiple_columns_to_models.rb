class AddMultipleColumnsToModels < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses
    add_reference :items
    add_reference :cart_items
    add_reference :orders
    add_reference :order_details
  end
end
