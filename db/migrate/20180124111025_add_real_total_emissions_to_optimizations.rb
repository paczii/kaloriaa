class AddRealTotalEmissionsToOptimizations < ActiveRecord::Migration
  def change
    add_column :optimizations, :realtotalemissions, :float
  end
end
