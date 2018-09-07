class AddEmissionsToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :emissions, :float
    add_column :routes, :boxes, :integer
    add_column :routes, :coolingboxes, :integer
    add_column :routes, :freezingboxes, :integer
  end
end
