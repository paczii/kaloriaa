class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :name
      t.float :range
      t.float :emissions
      t.float :speed
      t.float :boxcapacity
      t.float :coolingboxcapacity
      t.float :freezingboxcapacity
      t.float :capacity

      t.timestamps null: false
    end
  end
end
