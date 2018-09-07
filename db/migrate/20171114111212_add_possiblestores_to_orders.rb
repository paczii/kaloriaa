class AddPossiblestoresToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :possiblestores, :string
  end
end
