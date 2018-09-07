class AddEmissionsToOptimizations < ActiveRecord::Migration
  def change
    add_column :optimizations, :emissions, :float
  end
end
