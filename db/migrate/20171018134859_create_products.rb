class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.float :price
      t.float :discountprice
      t.string :description
      t.float :weight
      t.string :ingredients
      t.string :size
      t.float :sqm
      t.boolean :vegan
      t.boolean :bio
      t.string :picture
      t.boolean :cool
      t.boolean :freeze
      t.string :durability
      t.string :category

      t.timestamps null: false
    end
  end
end
