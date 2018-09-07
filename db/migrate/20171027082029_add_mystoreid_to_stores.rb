class AddMystoreidToStores < ActiveRecord::Migration
  def change
    add_column :stores, :mystoreid, :string
  end
end
