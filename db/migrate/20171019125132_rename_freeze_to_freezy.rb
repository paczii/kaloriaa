class RenameFreezeToFreezy < ActiveRecord::Migration
  def change
    rename_column :products, :freeze, :freezy

  end
end
