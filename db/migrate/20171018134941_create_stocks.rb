class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :product_id
      t.integer :store_id
      t.boolean :stock

      t.timestamps null: false
    end
  end
end
