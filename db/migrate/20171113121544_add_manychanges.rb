class AddManychanges < ActiveRecord::Migration
  def change

    rename_column :drivers, :vehicle, :vehicle_id
    rename_column :drivers, :driverid, :name
    remove_column :drivers, :route, :string
    remove_column :drivers, :totaltraveltime, :float
    remove_column :drivers, :totaldistance, :float
    remove_column :drivers, :totalemissions, :float
    remove_column :drivers, :boxes, :float
    remove_column :drivers, :coolingboxes, :float
    remove_column :drivers, :freezingboxes, :float

    #change_column :optimizations, :orders, :integer
    change_column :optimizations, :orders, 'integer USING CAST(orders AS integer)'

    add_column :optimizations, :stores, :integer
    remove_column :optimizations, :drivers, :string
    remove_column :optimizations, :totalcosts, :float
    remove_column :optimizations, :useddrivers, :string
    remove_column :optimizations, :usedstores, :string

    remove_column :products, :ingredients, :string
    remove_column :products, :size, :string
    remove_column :products, :cool, :boolean
    remove_column :products, :freezy, :boolean
    rename_column :products, :sqm, :volume
    #change_column :products, :durability, :integer
    change_column :products, :durability, 'integer USING CAST(durability AS integer)'

    remove_column :routes, :totalcosts, :float
    remove_column :routes, :totalprofit, :float

    remove_column :stocks, :default, :float
    #change_column :stocks, :stock, :boolean
    #change_column :stocks, :stock, 'boolean USING CAST(stock AS boolean)'

    remove_column :stores, :mystoreid, :string

    add_column :users, :driver, :boolean

    remove_column :vehicles, :capacity, :float

  end
end

