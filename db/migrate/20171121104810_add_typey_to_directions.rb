class AddTypeyToDirections < ActiveRecord::Migration
  def change
    add_column :directions, :typey, :string
  end
end
