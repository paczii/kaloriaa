class AddStatusToDistances < ActiveRecord::Migration
  def change
    add_column :distances, :status, :string
  end
end
