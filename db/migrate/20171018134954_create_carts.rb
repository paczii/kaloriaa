class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :items
      t.integer :customer_id
      t.integer :numberofitems
      t.string :products
      t.float :price

      t.timestamps null: false
    end
  end
end
