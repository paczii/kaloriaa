class CreateOptimizations < ActiveRecord::Migration
  def change
    create_table :optimizations do |t|
      t.integer :optimizationtype
      t.string :orders
      t.string :drivers
      t.integer :totalboxes
      t.integer :totalcoolingboxes
      t.integer :totalfreezingboxes
      t.string :allocation
      t.string :routes
      t.float :totaltraveltime
      t.float :totaldistance
      t.float :turnover
      t.float :productcosts
      t.float :worktimecosts
      t.float :drivingcosts
      t.float :totalcosts
      t.float :profit
      t.string :useddrivers
      t.string :usedstores

      t.timestamps null: false
    end
  end
end
