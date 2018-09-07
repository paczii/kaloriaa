class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :city
      t.string :street
      t.integer :zip
      t.integer :concept
      t.string :area

      t.timestamps null: false
    end
  end
end
