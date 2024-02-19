class AddMultipleColumnsToModels < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :customer, foreign_key: true
    add_reference :items, :genre, foreign_key: true
    add_reference :cart_items, :customer, foreign_key: true 
    add_reference :cart_items, :item, foreign_key: true
    add_reference :orders, :customer, foreign_key: true
    add_reference :order_details, :order, foreign_key: true
    add_reference :order_details, :item, foreign_key: true
  end
end
