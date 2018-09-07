class AddOrderslist < ActiveRecord::Migration
  def change
    add_column :optimizations, :orderslist, :string

  end
end
