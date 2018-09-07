class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :driver_id
      t.integer :optimization_id
      t.string :day
      t.string :route
      t.float :traveltime
      t.float :traveldistance
      t.float :worktimecosts
      t.float :drivingcosts
      t.float :totalcosts
      t.float :totalprofit

      t.timestamps null: false
    end
  end
end
