class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def change
    change_column :orders, :timewindow, :string

  end
end
