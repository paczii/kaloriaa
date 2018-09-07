class AddRealTotalDistanceToOptimizations < ActiveRecord::Migration
  def change
    add_column :optimizations, :realtotaldistance, :float
  end
end
