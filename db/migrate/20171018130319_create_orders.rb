class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :customer_id
      t.integer :allocationmethod
      t.string :day
      t.integer :timewindow
      t.string :products
      t.float :neededboxes
      t.float :neededcoolingboxes
      t.float :neededfreezingboxes
      t.integer :allocatedstore
      t.integer :allocateddriver
      t.string :estimatedtime
      t.integer :status

      t.timestamps null: false
    end
  end
end
