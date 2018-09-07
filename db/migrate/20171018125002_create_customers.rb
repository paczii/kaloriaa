class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.integer :user_id
      t.string :name
      t.string :city
      t.string :street
      t.integer :zip
      t.integer :costmodel
      t.string :favorites
      t.string :workcity
      t.string :workstreet
      t.integer :workzip

      t.timestamps null: false
    end
  end
end
