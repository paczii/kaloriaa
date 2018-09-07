class AddTypeToDistances < ActiveRecord::Migration
  def change
    add_column :distances, :typey, :integer
  end
end
