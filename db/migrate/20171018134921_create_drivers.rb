class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.integer :store_id
      t.integer :vehicle
      t.string :route
      t.float :totaltraveltime
      t.float :totalemissions
      t.float :totaldistance
      t.float :boxes
      t.float :coolingboxes
      t.float :freezingboxes

      t.timestamps null: false
    end
  end
end
