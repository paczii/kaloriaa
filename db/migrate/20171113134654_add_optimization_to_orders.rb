class AddOptimizationToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :optimization, :integer
  end
end
