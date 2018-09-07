class AddDriveridToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :driverid, :string
  end
end
